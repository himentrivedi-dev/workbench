# Enterprise AI / Agentic Systems Workbench

A practical research and architecture workbench for production-grade AI systems, with a focus on travel agents, tool orchestration, planner latency, retrieval, context engineering, memory, execution, and evaluation.

## Research map

| Area | What is captured | Key outcome |
|---|---|---|
| [Planning](01-planning/README.md) | Planner gates, dynamic DAGs, hierarchical planning, planner/executor/verifier | Avoid expensive planning when it is unnecessary |
| [Multi-Agent](02-multi-agent/README.md) | Supervisor/worker, parallel agents, blackboard/state patterns | Split responsibilities without losing control |
| [Tool Routing](03-tool-routing/README.md) | 43-tool problem, capability registry, tool gateways, dynamic discovery | Reduce tool-selection cost and context size |
| [Context](04-context/README.md) | Headroom, artifact offloading, context engineering, caching | Send only useful context to the model |
| [Memory](05-memory/README.md) | Letta/MemGPT, trip state, long-term memory evaluation | Persist state without replaying the whole journey |
| [Retrieval](06-retrieval/README.md) | Agentic search, hybrid retrieval, OKF/RAG | Combine structured, lexical, semantic and geographic retrieval |
| [Execution](07-execution/README.md) | DAG runtime, parallelism, retries, recovery, selective replay | Execute plans efficiently and safely |
| [Evaluation](08-evaluation/README.md) | BFCL, τ-bench, LongMemEval, travel-specific harness | Measure latency, correctness, cost and reliability |
| [Production Patterns](09-production-patterns/README.md) | Production case studies and architecture patterns | Separate proven patterns from interesting ideas |
| [Reference Implementations](10-reference-implementations/README.md) | Repositories, papers and articles | Reusable implementation starting points |
| [Travel Reference Architecture](11-travel-reference-architecture/README.md) | Hotel + Activity + Flight target architecture | Apply the research to the actual travel problem |

## Decision framework

Each idea is classified as:

- **ADOPT** — strong fit for the current architecture and low enough risk to implement.
- **EXPERIMENT** — promising, but requires an internal benchmark or prototype.
- **WATCH** — useful architectural signal, but insufficient production evidence.
- **REJECT** — conflicts with correctness, latency, operational or source-of-truth requirements.

## Core principle

> Do not make the LLM solve a problem that deterministic software, a cache, a capability registry, a retrieval layer, or a DAG scheduler can solve faster and more reliably.

## Current target architecture

`User -> Planner Gate -> Direct Domain Agent OR Dynamic Planner -> Capability/Dependency Registry -> DAG Runtime -> Parallel Tool Execution -> Validation/Merge -> State + Artifacts -> Response`

The existing dynamic planner remains valuable. The main optimization is to **avoid invoking it for high-confidence single-domain requests**, while preserving it for multi-domain, ambiguous, or genuinely compositional requests.

## Travel-specific benchmark goal

The primary KPI is not raw model latency. It is:

**cost + p95 latency per successfully completed, constraint-correct travel plan**.

See [Travel Reference Architecture](11-travel-reference-architecture/README.md) and [Evaluation](08-evaluation/README.md).
