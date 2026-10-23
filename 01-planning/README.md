# 01 — Planning

## Purpose

Research patterns for deciding **when to plan**, **what to plan**, and **how to represent dependencies**.

## Key patterns

### Planner Gate — ADOPT / EXPERIMENT
Use a cheap first-stage classifier/router to decide whether the full planner is necessary.

- High-confidence single-domain query → direct domain agent.
- Multi-domain, ambiguous, or compositional query → existing dynamic planner.
- Track false-bypass rate as a safety KPI.

### Dynamic DAG Planner — ADOPT
The existing planner dynamically creates a DAG from tool/domain dependencies. Keep this as the general-purpose fallback rather than replacing it.

### Hierarchical Planning — EXPERIMENT
Separate high-level journey selection from low-level tool sequencing. Useful when the tool catalog grows beyond a single planner's practical context.

### Planner / Executor / Verifier — EXPERIMENT
Separate planning from execution and validation. The verifier should validate constraints and tool outcomes rather than regenerate the whole plan.

## Travel fit

Flight example: search-unit → search-results is sequential; calendar can be independent for cheapest-flight intent; offers and price validation can run in parallel; booking depends on the search identifier.
