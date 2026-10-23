# 07 — Execution

## Purpose

Turn a plan into reliable, observable and low-latency execution.

## Patterns

- DAG execution with dependency-aware scheduling.
- Parallel execution of independent nodes.
- Timeouts, retries and circuit-breaking at tool boundaries.
- Durable state and resumability.
- Selective replay after a failed node rather than restarting the journey.
- State-machine patterns for explicit lifecycle transitions.

## Key separation

The Planner answers **what should happen**. The Execution Engine answers **when and how it runs**. Mixing these responsibilities increases planner latency and makes recovery harder.
