# 09 — Production Patterns

## Purpose

Collect production-oriented evidence and separate architectural patterns from marketing claims.

## High-value references already studied

- Anthropic multi-agent research system — delegation, parallel workers, context isolation and synthesis.
- OpenAI function calling at 340 tools / 12 tenants — tool scale, routing and production traffic concerns.
- Ferrata — tool gateway / infrastructure direction.
- Production agent runtime patterns — durable execution, recovery, policy and observability.
- Prompt/context caching and Redis semantic caching — avoid repeated expensive computation.

## Evidence standard

For each new reference record:

- Problem solved
- Architecture
- Measured results, if published
- Production evidence vs prototype
- Failure modes
- Applicability to travel
- Implementation cost
- Decision: ADOPT / EXPERIMENT / WATCH / REJECT
