# Travel & Lodging Evaluation: Dimension-to-Benchmark Map

## Position

There is no single public benchmark that validates a production lodging retrieval service over a private, changing, multi-supplier catalog. Public travel benchmarks are useful inputs, but many evaluate planning agents against fixed tools/data. They do not replace catalog-specific relevance judgments, source-of-truth checks, or production telemetry.

Use public resources for methodology and seed tasks; use a private, versioned golden set for release decisions.

## Dimension map

| Dimension | What to measure | Primary evaluation method | Best public reference / what to borrow | Must be built against our catalog? |
|---|---|---|---|---|
| Query understanding | intent, destination, dates, occupancy, rooms, budget, amenities, policies, missing slots | field-level exact match/F1; slot completeness; clarification precision/recall | TravelBench single-turn, multi-turn and unsolvable task design | Yes |
| Entity and place resolution | property, city, neighborhood, POI, airport, aliases, coordinates | entity accuracy; top-k entity recall; geodesic error; ambiguity calibration | TravelBench tool-grounded interaction patterns | Yes |
| Candidate retrieval | relevant properties in top 10/20/100 | Recall@K, Success@K, candidate coverage | HotelQuEST query complexity; standard IR | Yes; qrels are catalog-specific |
| Ranking | best candidates ordered highest | NDCG@K, MRR, MAP, pairwise accuracy | Expedia LTR implementation; PriceBench choice diagnostics | Yes |
| Hard constraints | dates, occupancy, max price, availability, star range, must-have amenities, cancellation rules | per-constraint micro pass; all-constraints macro pass; violation rate | TravelPlanner hard-constraint micro/macro/final pass-rate design | Yes; use actual search inventory and policies |
| Soft preferences | quiet, family-friendly, romantic, business-oriented, near nightlife | graded relevance; blinded human preference; calibrated LLM judge as secondary | HotelQuEST complex/underspecified query design | Yes |
| Multi-turn clarification | asks only necessary questions; incorporates answers; recognizes impossible requests | task completion; clarification utility; turns-to-resolution; unsolvable recognition | TravelBench (single-turn, multi-turn, unsolvable) | Yes |
| Price/value and choice bias | price sensitivity, quality trade-off, brand/position bias | paired option swaps; conditional-logit/preferences; price regret; position-swap consistency | PriceBench | Yes; adapt to your market, currency, and inventory |
| Tool/API reliability | correct endpoint, arguments, sequencing, retries, policy compliance | tool-call validity; schema validity; error/retry rate; pass^k across repeats | tau-bench; HotelOps-Bench as an exploratory template | Yes |
| Groundedness | amenity, policy, location, room, and property claims supported by catalog/source | claim-level precision/recall; unsupported-claim rate; source attribution coverage | Deterministic catalog lookup + human-reviewed claim labels | Yes |
| Query robustness | typos, transliteration, code-mix, aliases, abbreviations, vague and conflicting requests | slice-level success/recall; graceful-zero-result rate; false-positive rate | TravelBench unsolvable cases; custom perturbation suites | Yes |
| Geo/spatial relevance | radius, distance bands, neighborhood containment, route-aware proximity | geo precision/recall; distance error; in-radius violation rate | TravelEval spatiality dimension | Yes |
| Freshness and temporal correctness | price/inventory/availability/policy freshness and check-in date correctness | stale-result rate; source timestamp lag; temporal constraint pass rate | TravelEval temporality dimension | Yes; requires source timestamps |
| Supplier fairness/coverage | exposure, recall and ranking across suppliers, chains, regions and independent properties | supplier coverage; exposure parity conditional on relevance; concentration; position-swap tests | PriceBench brand/position diagnostics | Yes; avoid equal-exposure quotas that harm relevance |
| Data quality | completeness, validity, normalization, duplicate identity, coordinate/address consistency | field completeness; validity; duplicate rate; entity-resolution precision/recall | Internal data-quality assertions | Yes |
| End-to-end travel composition | lodging compatible with flights, activities, trip dates, group needs and itinerary constraints | end-to-end all-constraints pass; cross-domain consistency; executable booking-ready rate | TravelPlanner, TravelEval, TREK, WebTailBench | Yes; separate component scores from journey score |
| Efficiency and reliability | p50/p95/p99, throughput, cost/query, timeouts, retries, availability | load tests; latency histograms; cost per successful query; timeout/error rate | HotelQuEST quality/efficiency trade-off; tau-bench repeated-run reliability | Yes; production-like environment |
| Business outcomes | click, shortlist, conversion, cancellation, margin, customer satisfaction | online randomized A/B; guardrail metrics; cohort analysis | No offline benchmark is a substitute | Yes |

## Public resources: correct role and caveats

### HotelQuEST
https://github.com/amazon-science/hotel-quest-benchmark

Use as a hotel-query complexity and quality/efficiency benchmark reference. It is not a substitute for relevance judgments over our property IDs, supplier feeds, prices, or availability.

### TravelPlanner
https://github.com/OSU-NLP-Group/TravelPlanner

Borrow its hard-constraint micro pass rate (fraction of constraints satisfied), macro pass rate (fraction of plans satisfying every applicable constraint), and final all-constraints pass rate. Its travel itineraries and sandbox are not our lodging search catalog.

### TravelEval
https://arxiv.org/abs/2606.01046

Borrow the six-dimensional scorecard vocabulary: accuracy, compliance, temporality, spatiality, economy, and utility. Treat it as a planning-level framework, not an established lodging retrieval metric suite. Verify code availability before depending on an implementation.

### TravelBench (ACL 2026)
https://aclanthology.org/2026.acl-long.1347/

Borrow single-turn, multi-turn, and unsolvable task splits; cached tool results and sandboxing for reproducibility; explicit tool-call error accounting. It evaluates tool-using travel tasks, not catalog-wide retrieval relevance.

### PriceBench
https://arxiv.org/abs/2609.31468
https://pashasan.github.io/PriceBench/

Borrow paired option-order swaps and preference estimation to diagnose position, price, quality, and brand effects when an LLM selects/ranks hotel options. Its NYC property pool and task distribution are not representative of every market.

### tau-bench
https://github.com/sierra-research/tau-bench

Borrow tool-use policy adherence and pass^k: the probability of succeeding consistently across k independent trials. Treat its domain tasks as methodology, not lodging retrieval qrels.

### HotelOps-Bench
https://github.com/rrhoopes3/HotelOps-Bench

Treat as an early exploratory hotel-operations task template, not a mature or authoritative benchmark. Inspect task quality, maintenance, licensing, and reproducibility before adoption.

### TREK
https://github.com/TonyQJH/TREK-A-Travel-Reasoning-and-Evaluation-Kit-for-LLM-Agents-in-Complex-Trip-Planning

Borrow deterministic constraint checking, typed infeasibility, truthfulness, executability, and efficiency concepts for trip-level composition.

### WebTailBench
https://huggingface.co/datasets/microsoft/WebTailBench

Borrow broad travel task coverage across hotels, flights, activities, and compositional tasks. Use it for agent/workflow smoke tests, not as a replacement for catalog-specific IR qrels.

### Expedia LTR
https://github.com/matthewevans87/expedia-ltr

Borrow the separation of candidate retrieval and ranking and standard IR metrics. Verify dataset provenance, license, and representativeness before using its data for any production claims.

## Evaluation evidence hierarchy

1. Deterministic assertions against versioned source-of-truth snapshots.
2. Human-adjudicated qrels and pairwise preferences, with adjudication guidance.
3. Behavioral tests with cached/frozen tool responses.
4. Calibrated LLM judges for genuinely subjective soft preferences, validated against human labels.
5. Online randomized experiments for business outcomes.

Never use an LLM judge to override a deterministic hard-constraint failure.
