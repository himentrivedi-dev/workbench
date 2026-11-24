# Shared Evaluation Scenario Catalogue

These are starter scenarios for the skills in this workbench. They are test prompts and expected evaluation focus, not claims about actual system behaviour.

Use the detailed examples in the skill files and the existing `travel-lodging-eval/` dataset where relevant. Keep expected outcomes separate from the model output being evaluated.

## First Principles
1. A team proposes one central service for Flights, Hotels, and Activities. Challenge the assumption; compare central orchestration with domain-owned services and explicit integration boundaries.
2. A product request says, "Make activity search smarter." Ask for the user problem, success measure, constraints, and missing facts before selecting a solution.
3. A proposed LLM workflow performs deterministic filtering, sorting, and deduplication. Identify which parts should remain deterministic and explain why.
4. Two requirements conflict on latency and ranking quality. Surface the trade-off and ask what decision or evidence is needed.
5. The user strongly advocates one architecture. Do not simply agree; test it against requirements and alternatives.

## Requirements Engineering
1. Convert "show relaxing activities near water" into testable requirements without assuming unprovided distance, budget, or availability rules.
2. Handle contradictory preferences, such as "quiet activity" and "large crowded event."
3. Handle missing dates, guest count, location, and ambiguous terms.
4. Distinguish mandatory constraints from preferences and ranking signals.
5. Trace each acceptance criterion to a requirement and identify uncovered requirements.

## Architecture Design
1. Design an activity retrieval service with structured, lexical, semantic, and geographic retrieval.
2. Compare domain-owned services with a single central service for Flights, Hotels, and Activities.
3. Design a dynamic planner that builds a DAG from intent and dependencies; explain when a simple domain router is sufficient.
4. Identify data ownership, API contracts, failure isolation, and operational responsibilities.
5. Explain why the chosen architecture is appropriate and when it should be revisited.

## Engineering Implementation
1. Implement a small API change with explicit acceptance criteria and tests.
2. Work in a repository with unrelated pre-existing changes; preserve them.
3. Handle a change with a dependent API contract and migration.
4. Implement timeout, retry, and idempotency behaviour without hiding partial failure.
5. Stop and ask when requirements or ownership are too unclear to implement safely.

## Technical Review
1. Review a PR that has a real correctness defect and several harmless style differences.
2. Review a central planner proposal with no evidence that it outperforms a simple router.
3. Review an AI agent flow for tool selection, DAG dependencies, retries, and recovery.
4. Review a retrieval change for recall, ranking, geo fit, freshness, and hard-constraint correctness.
5. Review a change where tests were not run; state that limitation rather than implying success.

## Engineering Quality
1. Assess an activity retrieval service for correctness, latency, reliability, security, scalability, observability, maintainability, and cost.
2. Distinguish measured p95 latency from an unverified estimate.
3. Evaluate retrieval with Recall@K, MRR, and nDCG using a labelled set.
4. Identify missing production signals, SLOs, alerting, and recovery behaviour.
5. Prioritise quality risks by user and business impact.

## Technical Writing
1. Rewrite a jargon-heavy technical summary for engineers without changing technical meaning.
2. Explain the same architecture to engineering leadership and a non-technical stakeholder.
3. Simplify a sentence that contains multiple conditions without removing a constraint.
4. Identify unsupported claims, ambiguous pronouns, undefined acronyms, and inconsistent terminology.
5. Write a procedure with prerequisites, ordered steps, expected results, and recovery guidance.

## Diátaxis Documentation
1. Classify content into tutorial, how-to, explanation, or reference.
2. Split a mixed API onboarding document into the four documentation types.
3. Detect a tutorial that assumes prior setup without stating prerequisites.
4. Detect reference documentation that contains opinionated conceptual explanations instead of precise facts.
5. Identify missing documentation type for a new API consumer task.

## Architecture Documentation
1. Document an Activity Retrieval API using context, container, and component views where useful.
2. Produce an ADR comparing domain-level services with a central all-domain service.
3. Describe a sequence with request validation, retrieval, ranking, and response assembly.
4. Identify contradictions between diagrams, API contracts, and current implementation.
5. Explain which views are useful for leadership versus engineers.

## Leadership Communication
1. Turn a technical project update into an executive summary with outcome, status, risk, and decision needed.
2. Explain a latency regression without unsupported certainty or excessive implementation detail.
3. Communicate a missed milestone with cause, impact, mitigation, owner, and revised forecast.
4. Summarise an architecture trade-off for leadership and preserve the important caveats.
5. Convert a long technical discussion into a concise decision record and next actions.

## Cross-skill scenarios
1. Ambiguous product idea → First Principles → Requirements → Architecture → Leadership decision.
2. Architecture proposal → Technical Review → ADR → Architecture Documentation.
3. PR implementation → Engineering Implementation → Technical Review → Engineering Quality.
4. API launch → Requirements → Quality assessment → Diátaxis documentation.
5. Production issue → evidence-based review → clear leadership communication → follow-up actions.
