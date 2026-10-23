# 05 — Memory

## Purpose

Persist useful journey state without replaying an entire conversation or all prior tool results.

## Patterns

- **Letta / MemGPT** — stateful agents with explicit memory blocks and tools for memory management.
- **Trip-state memory** — constraints, selected entities, completed steps, unresolved dependencies and user decisions.
- **Long-term memory evaluation** — test retrieval of updated, temporal and contradictory facts.

## Travel fit

Persist compact state such as destination, dates, traveler constraints, selected hotel, selected activities, completed DAG nodes and pending dependencies. Keep full inventory/tool payloads in artifacts or source systems.

Memory must not become the source of truth for price, availability or booking state.
