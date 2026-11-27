# API Design
- Use domain-oriented resource names and correct HTTP semantics.
- Define request/response schemas, validation, pagination, filtering, and error contracts.
- Separate authentication from authorization; authorize each protected operation.
- Define idempotency for retryable writes, plus timeouts, rate limits, and payload bounds.
- Consider backward compatibility, versioning, and deprecation.
- Use machine-readable errors (code, message, details, request_id); clients must not parse exception text.
- Ask: who owns the resource, what is source of truth, what happens on duplicate/stale/conflicting requests, and what are latency/availability expectations?
