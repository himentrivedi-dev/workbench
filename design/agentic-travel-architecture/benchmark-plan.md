# Agentic Travel Architecture — Benchmark Plan

## Objective

Measure whether architecture changes improve successful, constraint-correct travel outcomes rather than optimizing raw model latency alone.

## Variants

| Variant | Configuration |
|---|---|
| A | Existing dynamic planner and current execution |
| B | Planner Gate + existing planner |
| C | B + artifact offloading + selective retrieval |
| D | C + persistent trip-state memory |
| E | D + safe caching + parallel DAG scheduling + runtime model selection + recovery |

## Scenario groups

1. Simple single-domain search.
2. Multi-domain hotel + activity planning.
3. Flight journey with explicit API dependencies.
4. Cheapest-flight intent (calendar should be conditional).
5. Multi-turn changes to dates, budget, hotel, or activity.
6. Large retrieval result set and context pressure.
7. Stale inventory or conflicting supplier data.
8. Tool timeout, rate limit, and partial failure.
9. Concurrent requests and tenant isolation.
10. Booking/modify/cancel flows with side-effect safety.

## Metrics

- End-to-end p50/p95/p99 latency.
- Task completion rate and constraint-correct completion rate.
- Domain/tool routing accuracy; false-single-domain bypass rate.
- Budget/date/location/amenity correctness.
- Freshness violations and invalid-price/availability claims.
- Tool calls, tokens, and cost per successful task.
- Retry count, recovery rate, duplicate side effects, and redundant calls.

## Method

- Use a versioned, frozen query set and expected constraints.
- Run each variant under comparable model, tool, data, and concurrency conditions.
- Record traces with route decision, DAG nodes, dependency waits, tool timings, token usage, and validation outcomes.
- Report confidence intervals and slice metrics by scenario; do not report only aggregate averages.
- Add regression tests for every discovered failure mode.
- Roll out behind a feature flag and retain a safe fallback to the existing planner.

## Decision gate

Promote a change only if it improves cost/latency per successful constraint-correct plan without materially regressing correctness, freshness, tenant isolation, or side-effect safety.
