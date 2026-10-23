# 02 — Multi-Agent Systems

## Purpose

Patterns for splitting work across specialized agents while maintaining orchestration, shared state and deterministic execution boundaries.

## Patterns

- **Supervisor / worker** — one coordinator delegates bounded tasks.
- **Parallel specialist agents** — independent research/retrieval tasks execute concurrently.
- **Blackboard/shared state** — agents communicate through explicit state rather than copying every prior message.
- **Agent specialization** — keep domain-specific prompts/tools small and focused.
- **Multi-agent production system** — combine delegation with persistence, retries, observability and validation.

## Rule for the travel architecture

Do not create an agent merely because a domain exists. Create a specialist when specialization reduces context, improves tool selection, or enables meaningful parallelism.

The Planner remains the orchestration authority; domain agents should not independently invent cross-domain dependencies.
