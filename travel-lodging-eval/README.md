# Travel & Lodging Search Evaluation Framework

Production-oriented evaluation framework for improving travel and lodging retrieval/search efficacy without hiding failures behind a single LLM judge.

## Scope

The framework evaluates a travel/lodging search service across:

- Query understanding and intent extraction
- Entity/location resolution
- Candidate retrieval
- Ranking quality
- Hard and soft constraint satisfaction
- Geographic relevance
- Amenity/property-attribute grounding
- Price and availability correctness
- Supplier/property identity and deduplication
- Data completeness and freshness
- Robustness to typos, aliases, ambiguity, multilingual queries and adversarial constraints
- Search latency, throughput, cost and tool/API efficiency
- Regression and release gating
- End-to-end travel composition where lodging interacts with flights/activities

## Design principles

1. **Deterministic checks first.** If a property field, distance, price, availability, or constraint can be verified from structured data, do not ask an LLM to judge it.
2. **Separate retrieval from ranking.** Recall@K answers whether candidates were found; NDCG/MRR answer whether useful candidates were ordered well.
3. **Hard constraints are gates.** A result that violates an explicit hard constraint must be penalized or rejected even if semantically relevant.
4. **Quality and efficiency are co-equal.** A higher-quality system that costs 5x and is materially slower is not automatically better.
5. **Evaluate by query family.** Aggregate scores can hide failures in geo, price, amenities, ambiguity, or long-tail queries.
6. **Use A/B baselines.** Every retrieval/ranking/index/query-understanding change should be evaluated against a frozen baseline.
7. **Repeated runs for stochastic systems.** Report mean, variance and pass@k where applicable.
8. **No synthetic-only confidence.** Synthetic tests are useful for coverage and edge cases; production-derived/de-identified queries should anchor the benchmark whenever possible.

## Repository layout

```text
travel-lodging-eval/
├── README.md
├── architecture.md
├── evaluation-matrix.md
├── dataset-schema.md
├── configs/
│   └── baseline.yaml
├── datasets/
│   └── sample_queries.jsonl
├── evaluators/
│   └── retrieval_metrics.py
└── runners/
    └── service_adapter.py
```

## Quick start

The implementation is intentionally adapter-based. Connect `runners/service_adapter.py` to the existing lodging search API, then provide a golden dataset using the schema in `dataset-schema.md`.

```bash
python -m evaluators.retrieval_metrics --help
```

The first production milestone should be a frozen benchmark of real/de-identified lodging queries plus deterministic qrels and constraint labels. Add LLM-as-judge only for dimensions that cannot be verified structurally (for example, nuanced soft-preference usefulness).

## Recommended release gates

At minimum, gate releases on:

- Recall@20: no material regression
- NDCG@10: no material regression
- Hard-constraint violation rate: no regression
- Geo constraint accuracy: no regression
- Price/availability grounding: no regression
- P95/P99 latency: within SLA
- Cost/query: within budget
- No critical query-family regression

Thresholds belong in the environment-specific config rather than being hard-coded here.

## External research used

The framework incorporates ideas from HotelQuEST, TravelEval, TREK, Expedia hotel ranking work, WebTailBench travel tasks, and established IR metrics. All original source links are preserved in `references/index.md` as required by this repository.

## Benchmark mapping and release process

- [Dimension-to-benchmark map](dimension-benchmark-map.md): maps each evaluation dimension to public resources, metrics, and catalog-specific work.
- [Benchmark adoption plan](benchmark-adoption-plan.md): what to reuse from TravelPlanner, TravelBench, PriceBench, tau-bench, HotelOps-Bench, TravelEval, TREK, WebTailBench, HotelQuEST and Expedia LTR—and what not to claim.
- [Release gates and evaluation protocol](release-gates.md): hard gates, statistical discipline, slices, position-bias checks, and judge governance.

The benchmark map is an extension to the original retrieval foundation. Public benchmarks are methodology inputs; the release gate must be driven by our own versioned catalog snapshot, qrels, source-of-truth assertions, and service telemetry.
