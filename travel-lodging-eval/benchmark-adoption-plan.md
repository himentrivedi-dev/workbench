# Public Benchmark Adoption Plan

The public resources below are complementary. Adopt only the pieces that map to the system boundary being evaluated.

| Resource | Adopt now? | Reuse | Do not claim |
|---|---|---|---|
| TravelPlanner | Yes, methodology | hard-constraint micro/macro/final pass-rate grading | That its itinerary benchmark validates our hotel catalog retrieval |
| TravelBench (ACL 2026) | Yes, for conversational layer | single-turn, multi-turn, unsolvable splits; cached tool results; tool-error penalties | That it measures catalog-wide hotel Recall@K |
| PriceBench | Yes, if LLM ranks/chooses | original-vs-swapped options; estimate price/quality/brand and position effects | That its NYC-specific preferences generalize to our markets |
| tau-bench | Yes, for tool-using workflows | policy adherence, tool correctness, pass^k across repeated trials | That airline/customer-service tasks validate lodging ranking |
| HotelOps-Bench | Inspect first | seed hotel operations cases if relevant | That an early small benchmark is a mature standard |
| TravelEval | Use scorecard concepts | accuracy, compliance, temporality, spatiality, economy, utility | That a paper's dimensions are directly comparable to our IR metrics |
| TREK | Yes, for trip composition | deterministic constraint checking, infeasibility, executability | That trip-planning scores measure retrieval relevance |
| WebTailBench | Optional smoke suite | broad hotel/flight/activity/compositional task coverage | That task success gives catalog-specific qrels |
| HotelQuEST | Yes, hotel-query design | query complexity, underspecification, quality/efficiency analysis | That its finite query set represents our supplier catalog |
| Expedia LTR | Reference implementation | retrieval/ranking split and IR metrics | That historical click logs equal unbiased relevance labels |

## Recommended rollout

### Phase 0 — define service boundary
Document whether the tested API includes query parsing, geo resolution, filters, retrieval, ranking, supplier fan-out, live price/availability, and LLM response generation. Record what is excluded.

### Phase 1 — deterministic lodging retrieval benchmark
Start with a manually adjudicated, versioned set of representative queries and catalog snapshots. Implement qrels, hard-constraint assertions, geo checks, Recall@K, NDCG@K, MRR, latency and error metrics.

### Phase 2 — travel conversational/tool layer
Add TravelBench-style multi-turn and unsolvable cases, plus tau-bench-style tool correctness and repeated-run consistency.

### Phase 3 — choice bias and fairness
If an LLM selects or re-ranks hotels, add PriceBench-style order swaps and price/quality/brand preference diagnostics. Evaluate supplier exposure conditional on relevance and eligibility.

### Phase 4 — online business validation
Run controlled A/B tests for CTR, shortlist/save rate, booking conversion, cancellation, margin, and customer satisfaction. Guard against changes in traffic mix, inventory, price, and seasonality.

## Minimum viable benchmark size

Do not mistake a large synthetic dataset for a trustworthy benchmark. Start with a smaller high-quality gold set and expand by measured coverage gaps. Keep separate:
- development set for iteration
- public/adaptation set for broad smoke coverage
- hidden release holdout
- recent production sample for drift monitoring

Every case should have provenance and a reviewer/adjudication trail.
