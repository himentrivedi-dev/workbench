# 08 — Evaluation

## Purpose

Benchmark architecture changes instead of relying on anecdotal latency improvements.

## Public benchmark families

- **BFCL** — function/tool calling and argument selection.
- **τ-bench** — multi-turn tool-use workflows and state-changing APIs.
- **LongMemEval** — long-term memory retrieval and temporal updates.
- **MLflow GenAI evaluation/tracing** — experiment comparison, traces and production metrics.

## Travel-specific harness

Evaluate at minimum:

1. Simple single-domain requests.
2. Multi-domain vacation planning.
3. Complex dependency-heavy plans.
4. Multi-turn changes.
5. Large context / inventory stress.
6. Tool failures and timeouts.
7. Freshness and stale-data scenarios.
8. Concurrency and partial-failure scenarios.

Track p50/p95/p99 latency, task success, constraint satisfaction, tool-selection accuracy, token usage, tool calls, cost, redundant searches, recovery success and false Planner-Gate bypasses.

### Primary metric

**Cost + p95 latency per successfully completed, constraint-correct travel plan.**
