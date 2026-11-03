# Travel & Lodging Evaluation References

All sources below are included as research inputs; they are not treated as interchangeable benchmarks. The framework adapts the useful evaluation ideas to a production lodging retrieval/search service.

## 1. HotelQuEST — hotel/agentic search

- GitHub: https://github.com/amazon-science/hotel-quest-benchmark
- Paper: https://arxiv.org/abs/2605.22205
- Why used: 214 hotel search queries spanning simple-to-complex requests; explicit attention to quality/efficiency trade-offs, query complexity, underspecified preferences, cost, tokens and latency.

## 2. TravelEval — multidimensional travel planning

- Paper: https://arxiv.org/abs/2606.01046
- Why used: six-dimensional evaluation vocabulary: accuracy, compliance, temporality, spatiality, economy and utility; realistic accommodation/transport data and simulation-based evaluation. Useful for end-to-end travel slices rather than only lodging IR.

## 3. TREK — deterministic travel-agent evaluation

- GitHub: https://github.com/TonyQJH/TREK-A-Travel-Reasoning-and-Evaluation-Kit-for-LLM-Agents-in-Complex-Trip-Planning
- Paper: https://arxiv.org/abs/2607.26977
- Why used: deterministic evaluator, typed infeasibility, truthfulness, constraint satisfaction, executability and efficiency. Particularly useful design principle: do not make an LLM judge the source of truth when deterministic checks are possible.

## 4. WebTailBench — web travel tasks

- Dataset: https://huggingface.co/datasets/microsoft/WebTailBench
- Why used: includes 52 hotel tasks, 51 flight tasks, 80 activity tasks and compositional tasks in its current benchmark. Useful for broad travel-agent regression coverage and adversarial/realistic task design.

## 5. Expedia hotel ranking / learning-to-rank reference

- GitHub: https://github.com/matthewevans87/expedia-ltr
- Why used: useful reference for separating candidate retrieval from ranking and for Recall@K, NDCG and MRR-style evaluation.

## 6. Retrieval evaluation demo

- GitHub: https://github.com/hweller1/retrieval_eval_demo
- Why used: practical reference for Precision@K, Recall@K, NDCG and MRR evaluation and domain-specific retrieval datasets.

## Adaptation rule

These references are evidence and design inputs, not a reason to copy a large framework. The target implementation remains deliberately small: a service adapter + frozen query/qrel dataset + deterministic evaluators + slice/regression reporting + optional calibrated LLM judging only for genuinely subjective dimensions.
