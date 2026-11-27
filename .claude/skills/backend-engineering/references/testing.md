# Backend Testing
- Unit: deterministic domain rules and edge cases.
- Integration: DB/cache/broker/provider boundaries.
- API: validation, authz, status, schema, errors.
- Contract: compatibility between independently owned services.
- E2E: critical full-stack user journeys only.
Cover success, invalid input, missing resources, forbidden access, conflicts, dependency failure, timeout, duplicate request, and concurrency where relevant. Prefer observable behavior over private implementation details; mock only appropriate boundaries.
