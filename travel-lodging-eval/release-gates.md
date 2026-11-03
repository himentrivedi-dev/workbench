# Release Gates and Evaluation Protocol

## 1. Non-negotiable release gates

Set numeric thresholds from a measured baseline and business/SLA requirements. Do not copy arbitrary thresholds from public papers.

| Gate | Metric | Release rule |
|---|---|---|
| Hard constraints | violation count/rate for explicit must-haves | Zero known violations for deterministic hard constraints; any violation blocks release pending triage |
| Retrieval | Recall@20 and Recall@100 | No statistically meaningful regression overall or on critical slices |
| Ranking | NDCG@10 and MRR | Meet agreed non-inferiority margin; improvement claims require confidence intervals |
| Geo | in-radius precision / geo constraint pass | No regression; explicit radius constraints are hard gates |
| Price/inventory | price and availability correctness at requested dates/occupancy | No stale or fabricated values; freshness SLA must pass |
| Groundedness | unsupported catalog claims | Zero unsupported hard factual claims in deterministic claim checks |
| Robustness | critical slice pass rate | No critical slice may be hidden by aggregate performance |
| Reliability | timeout/error rate and pass^k for stochastic flows | Meet SLO; report repeated-run distribution |
| Performance | p95/p99 latency, throughput | Meet service SLO under representative load |
| Economics | cost per query and cost per successful query | Within approved budget; disclose quality/cost trade-off |
| Data integrity | duplicate, malformed, missing critical fields | No material regression; critical corruption blocks release |
| Safety/policy | policy and privacy violations | Zero critical violations |

## 2. Statistical discipline

- Freeze the evaluation dataset version, qrels, catalog snapshot, index version, query parser version, model, prompt, and service configuration.
- Keep a hidden holdout set. Do not tune against the release holdout.
- Use paired query-level comparisons for baseline vs candidate.
- Report sample counts, confidence intervals, and effect sizes, not just point estimates.
- Bootstrap by query (and, where appropriate, by destination/property cluster) to avoid overstating certainty from correlated examples.
- For stochastic LLM/tool paths, run at least 3 repetitions during development and increase repetitions for release decisions when variance is material. Report pass@1 and pass^k; do not treat pass^k as a substitute for single-run quality.
- Use deterministic replay with frozen tool responses for debugging; separately run live integration tests for freshness and supplier/API behavior.
- Maintain a fixed regression set plus a rotating recent-production sample.

## 3. Required slices

Always break out results by:
- destination/city and destination popularity (head vs long tail)
- language, locale, transliteration and code-mix
- query intent and complexity
- exact vs fuzzy property/place/entity lookup
- date horizon and seasonality
- occupancy, rooms, children/ages and group size
- price bands and currency
- amenity/policy type
- radius/distance band and urban vs remote
- supplier, chain vs independent, source feed
- catalog completeness/freshness tier
- zero-result, ambiguous, conflicting, and infeasible requests

Only publish aggregate metrics alongside slice metrics and sample counts.

## 4. Position-bias and supplier-fairness protocol

- Run each choice/ranking case in original and swapped candidate order.
- Compare selected property, rank correlation, exposure and utility after order swap.
- Measure supplier/brand exposure conditional on relevance, inventory eligibility, price, location and quality. Do not impose equal supplier exposure when relevance differs.
- Track concentration (e.g. share of top-k exposure by supplier/chain) and investigate unexplained shifts.
- Separate ranking bias from upstream catalog coverage bias.

## 5. Golden-set construction

Each case should include:
- stable query ID and query text
- locale/language and normalized intent
- dates, occupancy, rooms, children/ages where relevant
- hard constraints vs soft preferences, explicitly distinguished
- resolved entities and geo geometry/radius where known
- catalog snapshot/version and source timestamps
- eligible property IDs and graded qrels
- per-constraint expected outcomes and evidence field paths
- ambiguity/clarification expectation or expected infeasible outcome
- tags/slices and provenance (production, human-authored, synthetic, public benchmark adaptation)

Qrels must be tied to a catalog snapshot. A hotel can become unavailable, change price, close, or change amenities; timeless labels are unsafe for dynamic facts.

## 6. Judge governance

- Deterministic checks own structured facts: price, availability, occupancy, coordinates, amenities, policies, identity, timestamps, and schema validity.
- Human labels own the reference standard for nuanced relevance and subjective preference.
- LLM judges may assist with soft-preference grading only after calibration against a human-adjudicated sample.
- Blind judges to system identity and candidate variant.
- Measure judge-human agreement and disagreement; keep judge prompts/model/version fixed.
- Never let the same model generate all test cases, label all qrels, and judge its own outputs without independent review.

## 7. Change attribution

For each candidate release, change one major factor at a time where practical:
- query understanding/parser
- lexical retrieval
- vector retrieval/embedding
- hybrid fusion
- filters/geo
- ranking
- catalog normalization/enrichment
- cache
- supplier integration
- LLM orchestration

Record the hypothesis, expected metric movement, possible regressions, run ID, commit, and decision. Keep a change only when its measured benefit justifies latency, cost, operational complexity, and maintenance.
