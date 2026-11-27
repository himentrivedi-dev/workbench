# Architecture and Patterns
Decision sequence: identify capability/ownership → use case/invariants → external dependencies/failure modes → simplest viable architecture → record trade-offs.
- Adapter: isolate an external provider or incompatible interface.
- Strategy: interchangeable algorithms selected by explicit policy.
- Factory: creation logic is non-trivial or configuration-dependent.
- Decorator: add behavior without changing the core component.
- Repository: meaningful persistence boundary.
- CQRS: read/write needs materially differ; not a default.
ADR fields: context, decision, alternatives, consequences, risks, owner, date. State the problem a pattern solves.
