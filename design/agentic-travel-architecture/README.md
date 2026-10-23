# Agentic Travel Architecture

This is the canonical design document for the travel-agent architecture. External research notes and original source URLs live in [references/](../../references/README.md) and the [master reference index](../../references/index.md).

## Problem

The travel assistant has approximately 43 tools across journeys such as Flight, Hotel, and Activity. Calling a full LLM planner for every query increases latency and token cost. A flat tool catalog also increases routing ambiguity. Execution needs to respect API dependencies, dynamic inventory freshness, partial failures, and multi-turn changes.

## Target architecture

```text
User request
  -> Planner Gate / domain router
       -> high-confidence single-domain: direct domain path
       -> multi-domain, ambiguous, compositional: existing dynamic Planner
  -> capability + dependency registry
  -> DAG scheduler / execution runtime
  -> parallel independent tool calls; dependency-gated calls
  -> deterministic validation and merge
  -> durable trip state + artifact references
  -> response
```

## Design principles

1. Do not invoke the full planner when a safe, high-confidence direct route is sufficient.
2. Keep the dynamic planner for genuinely compositional work; do not replace it with a brittle collection of fixed flows.
3. Store tool contracts, required inputs, dependencies, freshness, timeout/retry policy, and authorization metadata in a capability registry.
4. Keep planning separate from execution: the planner decides what should happen; the runtime decides when and how nodes execute.
5. Use deterministic filtering and validation for dates, budget, inventory, location, policies, and booking-critical facts.
6. Keep large API payloads in artifacts/data stores; pass compact, relevant evidence to the model.
7. Persist concise trip state, not complete API responses. Price, availability, and booking state must be revalidated against authoritative systems.
8. Measure task success and constraint correctness alongside latency and cost.

## Planner Gate

Route a request directly only when confidence is high and the request can be satisfied within a single domain without cross-domain dependencies. Send multi-domain, ambiguous, or compositional requests to the existing planner.

Required safeguards:
- confidence threshold tuned on a labeled query set
- deterministic overrides for booking, cancellation, modification, and other high-impact actions
- fallback to full planning when routing confidence is low
- measure false-single-domain bypass rate and missed-domain rate
- log route, confidence, fallback reason, latency, and outcome

## Capability and dependency registry

A capability record should describe:
- capability/tool name and owning domain
- input/output schema and required identifiers
- prerequisites and produced artifacts/IDs
- side-effect classification and authorization requirements
- timeout, retry, idempotency, rate limits, and failure semantics
- data freshness requirements and validation rules

### Flight dependency example

- Search-unit API produces a search identifier.
- Search-results API depends on that identifier.
- Calendar API is independent and should run only when cheapest-flight intent calls for it.
- Offers and price/availability validation can run in parallel when their inputs are available.
- Booking depends on the relevant search/offer context and must revalidate current price and availability before committing.

## Context, retrieval, and memory

- Use structured filters for exact constraints, lexical retrieval for names/IDs, semantic retrieval for intent, and geospatial retrieval for distance.
- Filter and rank large hotel/activity results in deterministic code before model synthesis.
- Keep stable system instructions and tool contracts cache-friendly.
- Store large search results as artifacts; give the model only a relevant subset and artifact reference.
- Keep trip-state memory limited to dates, constraints, selections, user decisions, completed nodes, and unresolved dependencies.
- Treat compressed context and memory summaries as convenience layers, never as transaction truth.

## Multi-agent boundaries

Do not create an agent solely because a domain exists. Use specialist agents when they reduce context, improve tool selection, or allow real parallelism. The planner remains responsible for cross-domain composition and dependencies. Shared state should be explicit and schema-validated.

## Runtime reliability

The execution runtime should support bounded parallelism, per-tool timeouts, retries only when safe, idempotency for side effects, circuit breaking, partial failure reporting, durable node state, resumability, and selective replay of affected nodes. Never blindly replay a booking or other non-idempotent action.

## Architecture decisions

| Capability | Initial decision | Gate for wider adoption |
|---|---|---|
| Planner Gate | Experiment, target adoption | Routing quality and false-bypass rate meet thresholds |
| Dynamic DAG planner | Keep | Continue for multi-domain/compositional requests |
| Capability/dependency registry | Adopt | Versioned schemas and contract tests |
| Parallel DAG execution | Adopt where dependencies allow | Correctness under partial failures and concurrency |
| Hybrid retrieval | Adopt | Retrieval and constraint evaluations pass |
| Artifact offloading | Experiment | Lower context/latency without losing required facts |
| Persistent trip-state memory | Experiment | Memory accuracy, updates, and stale-fact tests pass |
| Prompt/context caching | Adopt where stable | Cache correctness and tenant isolation verified |
| Runtime model selection | Experiment | Quality-adjusted cost/latency improvement demonstrated |

## Evaluation plan

Benchmark architecture variants on the same frozen query set and representative concurrency:

A. Existing dynamic planner.
B. Planner Gate + existing planner.
C. B + artifact storage and selective retrieval.
D. C + persistent trip-state memory.
E. D + safe caching, parallel DAG execution, runtime model selection, and recovery.

Include simple single-domain requests, multi-domain vacation plans, dependency-heavy flight journeys, multi-turn changes, large inventory/context, stale data, tool timeout, partial failure, and concurrency.

Track:
- p50/p95/p99 end-to-end latency
- successfully completed constraint-correct task rate
- tool/domain routing accuracy and false bypass rate
- constraint satisfaction and freshness violations
- tool calls, tokens, and cost per successful task
- retries, recovery success, duplicate side effects, and redundant searches

**Primary KPI:** cost + p95 latency per successfully completed, constraint-correct travel plan.

## Source-backed research

Use the detailed source notes rather than duplicating their full content here:
- [OpenAI function calling at 340 tools](../../references/agentic-tooling/openai-function-calling-340-tools-production.md) — https://pub.towardsai.net/openai-function-calling-works-great-until-you-have-340-tools-12-tenants-real-production-traffic-fe02da116e39
- [Ferrata tool gateway](../../references/agentic-tooling/ferrata-tool-gateway.md) — https://github.com/rajumb502/ferrata
- [Headroom context compression](../../references/context/headroom-context-compression.md) — https://github.com/headroomlabs-ai/headroom
- [Anthropic context engineering](../../references/context/anthropic-effective-context-engineering.md) — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- [Letta stateful memory](../../references/memory/letta-stateful-agent-memory.md) — https://github.com/letta-ai/letta
- [BFCL tool-calling evaluation](../../references/index.md) — https://github.com/ShishirPatil/gorilla/tree/main/berkeley-function-call-leaderboard
- [tau-bench workflow evaluation](../../references/index.md) — https://github.com/sierra-research/tau-bench
- [LongMemEval memory evaluation](../../references/index.md) — https://github.com/xiaowu0162/LongMemEval

All external resources must be indexed in `references/index.md` and each detailed reference note must include its original source URL.
