# 04 — Context Engineering

## Purpose

Control token volume, preserve useful information, and avoid repeatedly sending large tool outputs to models.

## Patterns

- **Headroom-style compression** — compress large context while preserving important information; treat compressed context as lossy.
- **Artifact offloading** — store large API/tool outputs externally and pass compact references.
- **Just-in-time context** — retrieve detailed data only when the current reasoning step needs it.
- **Context caching / prompt caching** — keep stable instructions and schemas cache-friendly.
- **Code/tool-side filtering** — filter, aggregate and validate large travel datasets before exposing them to the LLM.

## Travel rule

Hotel and activity inventory is not conversational memory. Keep source-of-truth data in deterministic stores/APIs. Give the model compact summaries, filtered records and references to artifacts.
