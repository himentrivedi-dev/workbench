# Enterprise AI / Agentic Systems Workbench

A practical research and architecture workbench for production-grade AI systems, focused on travel agents, planner latency, tool routing, context engineering, retrieval, execution, and evaluation.

## Start here

- **[Canonical Agentic Travel Architecture](design/agentic-travel-architecture/README.md)** — target architecture, Planner Gate, capability/dependency registry, runtime, memory/context boundaries, and design decisions.
- **[Benchmark Plan](design/agentic-travel-architecture/benchmark-plan.md)** — variants, scenario matrix, metrics, and decision gates.
- **[Research Reference Index](references/index.md)** — curated external articles, papers, and repositories. Each detailed reference should preserve its original source URL.
- [Reference library README](references/README.md)
- [Research map](references/research-map.md)

## Focused design notes

| Topic | Focus |
|---|---|
| [Planning](01-planning/README.md) | Planner Gate, dynamic DAG planning, planner/executor boundaries |
| [Tool routing](03-tool-routing/README.md) | Capability registry, tool discovery, routing and tool selection |
| [Retrieval](06-retrieval/README.md) | Hybrid structured, lexical, semantic and geographic retrieval |
| [Execution](07-execution/README.md) | DAG scheduling, retries, recovery and durable execution |
| [Evaluation](08-evaluation/README.md) | Quality, latency, cost and travel-specific evaluation |

## Core principle

> Do not make the LLM solve a problem that deterministic software, a cache, a capability registry, a retrieval layer, or a DAG scheduler can solve faster and more reliably.

## Primary KPI

**Cost + p95 latency per successfully completed, constraint-correct travel plan.**

## Repository organization

- `design/`: internal architecture decisions and benchmark plans.
- `references/`: external research notes, original source links, and the master index.
- Numbered topic folders: focused design notes; the canonical end-to-end architecture lives under `design/agentic-travel-architecture/`.

When adding research, preserve the source URL in the detailed note and add the item to `references/index.md` in the same change.
