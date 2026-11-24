---
name: architecture-design
description: Design and challenge software and AI system architectures by clarifying requirements, comparing alternatives, defining boundaries, and recording trade-offs. Use for new systems or material changes.
---

# Architecture Design

## Workflow

1. Confirm problem, requirements, constraints, scale, ownership, and quality attributes.
2. Map system context, actors, external dependencies, and existing capabilities.
3. Define domain boundaries, responsibilities, data ownership, and interfaces.
4. Compare credible options, including incremental change and no change.
5. Evaluate trade-offs: correctness, latency, reliability, security, scalability, operability, cost, and team ownership.
6. Describe key runtime flows and failure/recovery paths.
7. Identify contracts, state, persistence, observability, and deployment implications.
8. Recommend an option with assumptions, risks, and revisit conditions.
9. Create an ADR using `agent-tooling/templates/adr.md` for consequential decisions.

## Output

- Context and drivers
- Requirements and quality attributes
- Context/container/component views as needed
- Options and trade-off table
- Proposed boundaries, interfaces, and data ownership
- Key sequences and failure modes
- Security and operational considerations
- Risks, open questions, and ADR

## Guardrails

- Do not select a pattern because it is fashionable.
- Avoid centralising unrelated domain behaviour without a demonstrated benefit.
- Do not draw diagrams that imply unverified implementation details.
- Distinguish current state from target state.
- Use C4, arc42, ADRs, and AWS Well-Architected as useful methods, not mandatory ceremony.

## Reference scenario

Design a travel AI platform integrating Flights, Hotels, and Activities. Compare domain-owned services integrated by a framework with a central service owning all domain logic. Make ownership, latency, independent release, shared orchestration, and failure isolation explicit.

## Evaluation

Use Architecture Design scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
