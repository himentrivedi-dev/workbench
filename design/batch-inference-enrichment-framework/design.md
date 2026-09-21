# Generic Batch Inference Enrichment Framework — Design Document

## 1. Problem Statement

We store raw data in an Iceberg table queried via Athena. There is a recurring
requirement to enrich this data using Amazon Bedrock batch inference:

- From a set of raw columns (e.g. 10 columns), derive additional **enrichment
  columns** (e.g. 5 columns) using an LLM (Claude, via Bedrock).
- From a subset of raw and/or enriched columns, generate **vector embedding
  columns** (e.g. 3 columns), one embedding per source column.
- A single raw record can therefore expand from 10 columns to ~16-18 columns
  once enrichment and embeddings are merged back in.

This enrichment pattern is not a one-off job — it recurs across many datasets
(e.g. lodging, and others in the future), and it is reported to save 50%+ in
inference cost compared to running everything on-demand. The goal is a
**generic, config-driven, dataset-agnostic framework** that can be pointed at
any dataset without rewriting code, and that is robust to partial and full
batch failures.

### Constraints

- **Allowed AWS services**: Lambda, Glue jobs, SNS (notifications), Airflow
  (already in place, used to schedule Glue jobs).
- **Not allowed**: Step Functions, SQS, DynamoDB.
- Need a **control table** to track ~20 batch inference jobs that can run in
  parallel. Candidates considered: Postgres vs. Iceberg. **Postgres was
  chosen** — it supports true row-level locking and transactional updates,
  which a control table under concurrent writes needs; Iceberg does not.
- Different datasets require different numbers of enrichment columns and
  vector fields — the framework must be **metadata/config-driven**, not
  hardcoded per dataset.
- Must handle **partial batch failures** and **full batch failures**, with a
  **record-level reprocessing/retry mechanism**.

---

## 2. Reference Material Reviewed

Several AWS sample repositories were reviewed for design patterns, none of
which could be used as-is due to the service constraints above, but each
contributed a specific pattern that was adapted:

| Repository | What it does | What we took from it |
|---|---|---|
| `aws-samples/sample-inference-using-aws-batch` | Uses AWS Batch (Fargate) + real-time Bedrock Converse API calls, streams into S3 Tables (Iceberg) with ACID upsert | Confirmed the value of **Iceberg upsert write mode** for the final merge step. Also clarified that this pattern uses **on-demand pricing**, not the batch-inference cost discount — not suitable given our 50%+ cost-saving requirement. |
| `aws-samples/sample-bedrock-batch-inference-orchestrator` | DynamoDB + Step Functions orchestrator for large-scale Bedrock batch inference (millions of images), with a `STAGING → IN_FLIGHT → DONE/FAILED` record lifecycle | The core design pattern we adapted onto Postgres: record-level status lifecycle, **cohort claiming**, **salvage-before-revert** on job completion, **byte-budget-aware cohort packing**, **idempotent job submission**, **deadline guards**, and **stranded-record alarming**. DynamoDB's GSI write-sharding workaround is unnecessary in Postgres — `SELECT ... FOR UPDATE SKIP LOCKED` achieves the same atomic claiming more simply. |
| `aws-samples/sample-step-functions-batch-inference` | Step Functions Distributed Map + Textract + Bedrock batch inference for a RAG/document pipeline | Validated the general pattern (fan-out processing → consolidate → batch inference → notify) but contributed no new mechanism specific to our design. |

---

## 3. Solution Architecture

### 3.1 High-level flow

```
Airflow DAG (per dataset, config-driven)
  → Glue Job: Preprocess           (read Iceberg raw table, build prompts, write JSONL to S3, register control-table rows)
  → Lambda 1: Registrar            (verify input file line count == control table row count)
  → Lambda 2: Scheduler            (check running-job quota, claim a cohort, submit Bedrock batch job)
  → Bedrock async batch job runs   (EventBridge rule watches for terminal state)
  → SNS notification on state change
  → Glue Job: Output Processor     (parse output JSONL + manifest.json.out, update control table, salvage before reverting failures)
  → Glue Job: Materialize          (MERGE INTO Iceberg staging/final table)
  → (for embedding) repeat the above, but only after the enrichment stage's output is materialized, since embedding inputs can depend on enrichment output
```

### 3.2 Why two Iceberg tables (staging → final)

Enrichment produces 5 new columns; some of those enrichment columns are then
used as **inputs** to the embedding stage. Embedding cannot start until
enrichment has completed and been written somewhere the embedding
pre-processing job can read from. A `dataset_staging` Iceberg table acts as a
checkpoint: raw + enrichment columns land there first, embedding reads from
it, embedding output is merged back into the same staging table, and only
once every column is populated is it published/swapped into the final
production Iceberg table.

### 3.3 Control table schema (Postgres)

Two linked tables — job-level metadata is kept separate from record-level
status so it is not duplicated across thousands of rows.

```sql
-- One row per submitted Bedrock batch inference job
batch_jobs (
  batch_job_id        TEXT PRIMARY KEY,
  dataset             TEXT,
  task_type           TEXT,           -- 'enrichment' | 'embedding'
  bedrock_job_arn     TEXT,
  model_id            TEXT,           -- e.g. anthropic.claude-sonnet-..., amazon.titan-embed-text-v2
  prompt_template_id  TEXT,
  config_version      TEXT,
  input_s3_path       TEXT,
  output_s3_path      TEXT,
  status              TEXT,           -- SUBMITTED / IN_PROGRESS / COMPLETED / PARTIALLY_COMPLETED / FAILED / STOPPED
  total_records       INT,
  success_count       INT,
  failed_count        INT,
  submitted_at        TIMESTAMP,
  completed_at        TIMESTAMP
);

-- One row per unit of work: a single record x a single task (enrichment, or one embedding sub-column)
batch_work_items (
  batch_record_id     TEXT PRIMARY KEY,   -- alphanumeric surrogate key; this IS the Bedrock recordId
  dataset             TEXT,
  original_record_id  TEXT,               -- primary key in the source Iceberg table
  task_type           TEXT,               -- 'enrichment' | 'embedding'
  sub_type            TEXT NULL,          -- NULL for enrichment; e.g. 'col_a' / 'col_b' / 'col_c' for embedding
  status              TEXT,               -- STAGING / IN_FLIGHT / DONE / FAILED
  batch_job_id        TEXT REFERENCES batch_jobs(batch_job_id),
  retry_count         INT DEFAULT 0,
  error_message       TEXT,
  output_value        JSONB,              -- parsed modelOutput once DONE
  materialized        BOOLEAN DEFAULT FALSE,
  created_at          TIMESTAMP,
  updated_at          TIMESTAMP
);
```

**Why `recordId` is a surrogate key, not an encoded string**: Bedrock requires
`recordId` to be an alphanumeric string — it does not reliably support
delimiter characters for encoding composite keys (dataset, task type,
sub-column) directly into it. Rather than encode meaning into the string, we
generate a plain alphanumeric UUID as the surrogate key and keep all context
(dataset, original record id, task type, sub-type) in the control table,
joined back via `batch_record_id`.

### 3.4 Cohort claiming (Postgres, no DynamoDB needed)

```sql
UPDATE batch_work_items
SET status = 'IN_FLIGHT', batch_job_id = :new_job_id, updated_at = now()
WHERE batch_record_id IN (
  SELECT batch_record_id FROM batch_work_items
  WHERE status = 'STAGING' AND dataset = :dataset AND task_type = :task_type
  ORDER BY created_at
  LIMIT :cohort_size
  FOR UPDATE SKIP LOCKED
)
RETURNING batch_record_id, original_record_id;
```

`FOR UPDATE SKIP LOCKED` gives atomic, concurrency-safe cohort claiming
without the GSI write-sharding complexity that a DynamoDB-based design needs
to work around a hot-partition limitation. Cohort size should be capped by
**both** a record-count limit (Bedrock's per-job record ceiling) and a
**byte-budget** limit (large prompts can hit Bedrock's job-size quota well
before the record-count ceiling).

### 3.5 Partial and full failure handling

Bedrock batch inference jobs can reach status `PartiallyCompleted` in addition
to `Completed` / `Failed` / `Stopped`. Two artifacts are produced per job:

- **Per-record output** (`*.jsonl.out`): each line either has a `modelOutput`
  (success) or an `error` object in its place (failure), keyed by `recordId`.
- **`manifest.json.out`**: job-level summary —
  `totalRecordCount / processedRecordCount / successRecordCount / errorRecordCount / inputTokenCount / outputTokenCount`.

**Salvage before revert**: regardless of the job's terminal status (even
`Failed` or `Stopped`), the output files are parsed first — any records that
did produce output represent inference that has already been paid for and
must not be discarded. Only after salvaging do we revert the remaining,
unprocessed work items back to `STAGING`.

**Record-level retry**: Bedrock batch inference does **not** support
resubmitting a single record within an existing job — a submitted job is
immutable. Retry is implemented entirely at the control-table layer:

1. Failed work items are set back to `status = 'STAGING'`, with
   `retry_count` incremented.
2. The next cohort-claiming query naturally picks these up as part of a
   future job submission.
3. After a configured retry cap (e.g. 3 attempts), a work item is marked
   `DEAD_LETTER` and an SNS alert is raised for manual review.
4. Bedrock job submission uses a deterministic `clientRequestToken` so a
   retried Lambda invocation cannot double-submit the same job.

### 3.6 Embedding: one-to-many mapping

A single raw record needing 3 embeddings (from 3 different source columns)
becomes 3 separate `batch_work_items` rows, each with the same
`original_record_id`, `task_type = 'embedding'`, and a distinct `sub_type`
(`col_a` / `col_b` / `col_c`). This can be generated after the enrichment
stage is materialized, since some embedding source columns are themselves
enrichment outputs.

**Materializing embeddings back into a single wide row (pivot)**:

```sql
SELECT original_record_id,
  MAX(CASE WHEN sub_type = 'col_a' THEN output_value END) AS embedding_col_a,
  MAX(CASE WHEN sub_type = 'col_b' THEN output_value END) AS embedding_col_b,
  MAX(CASE WHEN sub_type = 'col_c' THEN output_value END) AS embedding_col_c
FROM batch_work_items
WHERE task_type = 'embedding' AND status = 'DONE' AND NOT materialized
GROUP BY original_record_id;
```

This is then used as the source of a `MERGE INTO` against the Iceberg staging
table. Enrichment and embedding merges should not run concurrently against
overlapping rows, to avoid Iceberg optimistic-concurrency commit conflicts —
sequence them, or add commit-conflict retry logic.

### 3.7 Structured output for enrichment (Claude on Bedrock)

Bedrock's native **Structured Outputs** feature (`output_config.format` with
a JSON Schema, `strict: true`) is supported for the `InvokeModel` API and is
also supported under **Batch inference** and **Cross-Region inference**. This
is the recommended mechanism over manually prompting for JSON, since it
guarantees schema-conforming output and validates against the schema
server-side (400 error at submission time if the schema itself is invalid).

Note: for Anthropic models, Structured Outputs cannot be combined with the
Citations feature (not relevant to this use case).

Example batch input record (per raw record, enrichment task):

```json
{
  "recordId": "a1b2c3d4",
  "modelInput": {
    "anthropic_version": "bedrock-2023-05-31",
    "max_tokens": 1024,
    "messages": [{
      "role": "user",
      "content": [{"type": "text", "text": "<raw column values injected here>"}]
    }],
    "output_config": {
      "format": {
        "type": "json_schema",
        "json_schema": {
          "name": "lodging_enrichment",
          "strict": true,
          "schema": {
            "type": "object",
            "properties": {
              "sentiment_score": {"type": "number"},
              "category_tag": {"type": "string", "enum": ["family-friendly", "couples", "business", "budget-backpacker", "luxury"]},
              "quality_summary": {"type": "string"},
              "price_tier": {"type": "string", "enum": ["budget", "mid", "luxury"]},
              "policy_flags": {"type": "string", "enum": ["flexible-cancel", "moderate-cancel", "strict-cancel"]}
            },
            "required": ["sentiment_score", "category_tag", "quality_summary", "price_tier", "policy_flags"],
            "additionalProperties": false
          }
        }
      }
    }
  }
}
```

Matching output: `modelOutput.content[0].text` is a JSON **string** that
conforms exactly to the schema — parse it with a plain `json.loads()`, no
markdown-stripping or tool-call unwrapping required.

**Model choice**: Claude Opus and Sonnet were both considered ("heavy"
models). Opus is materially more expensive per token than Sonnet. Since the
model_id is already a per-job config field, it should default to Sonnet for
bulk datasets and be overridden to Opus only where output quality
specifically requires it — this is a config decision per dataset, not a
global hardcoded choice.

---

## 4. Reconciliation Checkpoints

Four points in the pipeline where counts are cross-checked to catch dropped
or stuck records:

1. **Input registration**: input JSONL line count == number of `STAGING` rows
   created in `batch_work_items` for that batch.
2. **Job completion**: `manifest.json.out` (`successRecordCount + errorRecordCount`)
   == number of `batch_work_items` rows tied to that `batch_job_id`.
3. **Stage gating**: embedding pre-processing only starts once enrichment
   work items for a record are `materialized = TRUE`.
4. **Final publish**: raw source table record count == final Iceberg table
   record count, with all derived + embedding columns populated.

---

## 5. Open Items / Next Steps

- Finalize Airflow trigger mechanism between the enrichment-complete state
  and the embedding-stage DAG (polling vs. sensor vs. external trigger).
- Confirm actual Bedrock account/model-level concurrent batch job quota
  (region- and model-specific) rather than relying on the assumed "20
  parallel jobs" business limit.
- Decide whether the final Iceberg `MERGE INTO` runs via Athena SQL or a
  Spark-based Glue job, given expected record volumes (millions of rows).
- Add cost/token tracking per job (input/output token counts are already
  available in `manifest.json.out` and per-record `usage` fields) to
  validate the expected 50%+ cost saving in practice.
- Decide on config schema versioning strategy so that a change to enrichment
  or embedding columns for a dataset doesn't silently affect in-flight jobs.
