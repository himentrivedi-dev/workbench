# Evaluation Matrix

## 1. Query understanding

| Dimension | Primary metrics | Deterministic evidence | Failure examples |
|---|---|---|---|
| Intent classification | accuracy, macro-F1 | labeled intent | lodging query routed to activities |
| Entity extraction | precision/recall/F1 | city, property, landmark, airport | wrong city |
| Date extraction | exact-match, tolerance accuracy | check-in/out | wrong date window |
| Occupancy | exact-match | adults/children/rooms | wrong party size |
| Budget | exact-match/range accuracy | min/max currency-normalized | ignores max price |
| Constraint parsing | precision/recall | hard vs soft labels | treats preference as hard |

## 2. Retrieval

| Dimension | Metrics |
|---|---|
| Candidate recall | Recall@5/10/20/50/100 |
| Precision | Precision@5/10/20 |
| Ranking | NDCG@5/10/20, MRR |
| First relevant result | MRR, hit rate@1 |
| Long tail | recall by popularity decile |
| Supplier coverage | recall by supplier/source |
| Property coverage | unique property recall |
| Duplicate control | duplicate rate@K |

## 3. Hard constraints

Evaluate each constraint independently and jointly:

- location/city
- geo radius/distance
- price ceiling/floor
- dates
- availability
- occupancy
- star/category
- amenity explicitly requested
- property type
- refundable/non-refundable when applicable

Metrics:

- constraint satisfaction rate
- hard-constraint violation rate
- per-constraint precision/recall
- joint constraint satisfaction
- impossible-query handling rate

## 4. Geographic relevance

Metrics:

- distance error
- geo hit@1/5/10
- radius recall
- median and P95 distance of returned results
- neighborhood accuracy
- landmark-to-hotel resolution accuracy
- airport/station proximity accuracy

## 5. Property and amenity grounding

For every requested property attribute, compare the returned claim to authoritative structured source data.

Metrics:

- amenity precision/recall
- attribute accuracy
- unsupported-attribute rate
- hallucination rate
- source-grounding coverage

## 6. Price and availability

Evaluate against the source-of-truth snapshot used for the request.

Metrics:

- price exact-match / tolerance accuracy
- currency conversion accuracy
- stale-price rate
- stale-availability rate
- availability precision/recall
- room/rate-plan match accuracy
- tax/fee treatment accuracy when exposed by the API

## 7. Data quality

Measure independently from retrieval quality:

- missing-field rate
- null/empty critical-field rate
- duplicate-property rate
- supplier conflict rate
- identity-resolution accuracy
- address accuracy
- coordinate accuracy
- city/country/pincode accuracy
- amenity normalization accuracy
- freshness SLA compliance

## 8. Robustness

Query families should include:

- spelling errors
- abbreviations
- aliases and alternate city names
- multilingual queries
- transliteration
- natural language
- vague preferences
- multi-constraint requests
- contradictory constraints
- impossible requests
- very long queries
- noisy conversational context
- adversarial/irrelevant terms

Report metrics by family, not only globally.

## 9. Supplier and index behavior

Measure:

- supplier recall
- supplier latency contribution
- supplier timeout rate
- index shard/query failure rate
- fallback success rate
- stale-index rate
- duplicate collapse accuracy
- canonical-property mapping accuracy

## 10. End-to-end travel planning

When lodging search is invoked as part of a trip planner, measure:

- correct lodging tool selection
- correct parameter propagation from planner
- preservation of flight/activity constraints
- itinerary consistency
- unnecessary search calls
- redundant retrieval
- cross-domain latency
- end-to-end task success

## 11. Efficiency

Measure both service-level and agent-level efficiency:

- P50/P95/P99 latency
- throughput/QPS
- CPU/memory where available
- OpenSearch query latency
- candidate count
- tool/API calls per request
- retries
- timeout rate
- tokens when an LLM is involved
- cost/request

## 12. Reliability

- error rate
- timeout rate
- partial-result rate
- fallback success
- deterministic replay success
- availability/SLA
- degradation behavior under supplier/index failures

## 13. Evaluation quality

The evaluation system itself must be tested:

- inter-annotator agreement
- qrel coverage
- label consistency
- benchmark leakage checks
- temporal leakage checks
- production-query representativeness
- metric confidence intervals
- slice coverage
- regression sensitivity

## 14. Recommended scorecard

Do not collapse all dimensions into one score for release decisions. Report a scorecard with hard gates plus weighted quality metrics.

Suggested gates:

1. No critical hard-constraint regression.
2. No critical price/availability regression.
3. No critical geo regression.
4. Recall@20 and NDCG@10 within agreed tolerance or improved.
5. P95/P99 latency within SLA.
6. Cost/query within budget.
7. No critical query-family regression.

Use an overall weighted score only for prioritizing experiments, not for masking a critical failure.