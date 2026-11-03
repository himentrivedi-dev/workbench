# Production Evaluation Architecture

```text
                 Frozen Evaluation Dataset
                          |
                    Query + Qrels
                          |
                    Service Adapter
                          |
                +---------+----------+
                |                    |
          Retrieval API        Optional Planner
                |                    |
                +---------+----------+
                          |
                   Raw Search Trace
                          |
        +-----------------+------------------+
        |                 |                  |
   IR Evaluators    Constraint Evaluators  Data/Geo
        |                 |                  |
        +-----------------+------------------+
                          |
                 Quality + Efficiency
                          |
                 Slice / Regression
                          |
                 Release Decision
```

## Golden dataset structure

Every case should contain:

- query text
- locale/language
- check-in/check-out
- occupancy
- normalized intent
- extracted entities
- hard constraints
- soft preferences
- expected geo target/radius
- qrels with graded relevance
- authoritative property facts used for verification
- source/snapshot timestamp
- expected failure behavior where the request is impossible

## Evaluation modes

### Offline replay

Use frozen search/index snapshots so a code/index change can be compared fairly.

### Shadow production

Replay de-identified production queries against candidate systems without affecting users.

### Online experiment

Only after offline gates pass. Compare business and system metrics with randomized traffic where appropriate.

## Golden dataset construction

Prefer this order:

1. De-identified real production queries with authoritative outcomes.
2. Human-authored edge cases from known failure modes.
3. Benchmark datasets such as HotelQuEST/TravelEval/TREK.
4. Synthetic query generation for coverage gaps.
5. Adversarial generation followed by human validation.

Synthetic cases must not become the only source of truth.

## Qrel design

Use graded relevance where possible:

- 3 = excellent result satisfying all hard constraints and strong soft preference match
- 2 = useful result satisfying hard constraints with weaker preference match
- 1 = partially useful but missing a meaningful preference
- 0 = irrelevant
- critical violation = explicit hard-constraint failure; report separately from generic relevance

Do not allow an LLM judge to override deterministic hard-constraint failures.

## LLM judge policy

Use an LLM judge only for dimensions that structured checks cannot reliably determine, such as nuanced soft-preference fit or natural-language response usefulness.

For judge-based metrics:

- use explicit rubrics
- keep reference context bounded
- calibrate against human labels
- report agreement
- test judge bias
- retain raw judge evidence
- never use a single judge score as the only release gate

## Regression strategy

Every candidate must be compared against a frozen baseline.

Track:

- aggregate metrics
- query-family slices
- supplier slices
- geographic slices
- popularity/long-tail slices
- language slices
- hard-constraint slices
- latency/cost

A candidate fails if it materially improves one aggregate metric while causing a critical slice regression.

## Statistical discipline

For stochastic systems run multiple repetitions. Report mean and confidence interval where meaningful. For paired query evaluation, prefer paired significance/bootstrap analysis over comparing independent aggregate averages.

## Travel-specific slices

At minimum:

- city search
- landmark proximity
- airport proximity
- beach/coast
- neighborhood
- price budget
- star/category
- amenity
- family/couple/business intent
- multi-room occupancy
- long-tail properties
- supplier-specific queries
- multilingual/alias queries
- impossible/contradictory queries

## Production telemetry

The service adapter should capture, where permitted:

- request ID
- normalized query
- search strategy
- index/version
- filters
- candidate count
- result IDs and scores
- latency by stage
- supplier/API calls
- retries/timeouts
- errors
- freshness timestamps
- cost/token data when applicable

Do not commit production PII, credentials, raw customer data, or proprietary supplier payloads into the benchmark repository.