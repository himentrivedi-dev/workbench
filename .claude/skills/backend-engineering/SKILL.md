---
name: backend-engineering
description: Design, build, review, refactor and investigate Python/FastAPI backends, APIs and service architecture.
---
# Backend Engineering

## Modes
Design (requirements, boundaries, contracts, trade-offs); Build (small complete change + tests); Review (prioritized findings with file/line references); Refactor (preserve behavior); Investigate (reproduce, separate facts from hypotheses).

## Workflow
1. Inspect repository conventions, dependencies, and tests.
2. Convert requirements into observable behavior; record assumptions.
3. Trace entry point → validation/auth → domain logic → persistence/integrations → response.
4. Choose the simplest architecture that meets constraints.
5. Implement incrementally; avoid unrelated cleanup.
6. Add unit, integration, API, or contract tests at the right level.
7. Run focused and relevant broader checks; report exact commands and outcomes.
8. Review security, concurrency, timeouts, retries, idempotency, observability, and operational impact.

## Python/FastAPI
- Type public interfaces; use Pydantic at API boundaries.
- Keep route handlers thin; business rules belong in application/domain services.
- Keep async/sync boundaries explicit; never block the event loop casually.
- Manage clients/pools with lifespan; set timeouts and pool limits.
- Enforce authorization on every protected operation.
- Return stable error contracts; never expose stack traces or secrets.
- Use structured logs and correlation IDs; redact sensitive data.

## Architecture
Start with domain ownership, use cases, invariants, and data flow. Prefer a modular monolith until independent deployment/scaling is justified. Use Adapter for external interfaces, Strategy for genuinely interchangeable algorithms, Factory for non-trivial creation, Repository only when it clarifies persistence boundaries. Explain trade-offs and avoid patterns for their own sake.

## Anti-patterns to challenge
Fat route handlers; generic utils/managers; premature microservices; hidden global state; import-time side effects; unbounded retries; missing timeouts; broad exception swallowing; N+1 queries; blocking I/O in async paths; over-mocking; duplicated sources of truth.

## Definition of done
Acceptance behavior tested; relevant checks run and reported; security/failure paths considered; API/config/docs updated; no unrelated changes/secrets; residual risks stated.

## References
Read only what is relevant: references/api-design.md, fastapi-python.md, architecture-patterns.md, reliability-security.md, testing.md.
