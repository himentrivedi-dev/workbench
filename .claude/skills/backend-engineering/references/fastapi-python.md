# Python and FastAPI
Suggested layers: router (HTTP/wiring), application service (use-case orchestration), domain (rules/invariants), infrastructure (DB/cache/broker/provider adapters). Use only layers that pay for their complexity.
- Manage shared resources through FastAPI lifespan.
- Keep dependencies explicit and correctly scoped.
- Do not block the event loop; set outbound connect/read/total timeouts.
- Validate configuration at startup and response models at boundaries.
- Test dependency overrides and authorization.
- Prefer clear names, type hints, small cohesive functions, context managers, and specific exceptions.
- Avoid mutable defaults, hidden state, import-time side effects, and clever metaprogramming without clear value.
