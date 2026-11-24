---
name: architecture-documentation
description: Create and maintain useful architecture documentation, including C4 views, ADRs, sequence flows, interfaces, quality attributes, and deployment views. Use for architecture proposals and system documentation.
---

# Architecture Documentation

## Workflow

1. Identify audience, purpose, system boundary, and whether the document describes current or target state.
2. Gather evidence from source code, API contracts, deployment configuration, owners, and existing decisions.
3. Write a concise context and scope.
4. Select only views that answer real questions:
   - C4 context and container views for system boundaries and responsibilities
   - Component views when internal structure matters
   - Sequence diagrams for runtime interactions
   - Deployment views for runtime topology and operations
   - ADRs for consequential choices
5. Document interfaces, data ownership, dependencies, and quality attributes.
6. Include failure modes, security boundaries, observability, and recovery where relevant.
7. Validate diagrams and prose against implementation and owners.
8. Link the result to the documentation structure defined by Diátaxis.

## Output

- Architecture summary and scope
- System context and container view
- Component or sequence views where useful
- Interfaces and data ownership
- Quality attributes and operational view
- ADRs and unresolved decisions
- Source links and validation date

## Guardrails

- Never fabricate components, traffic flows, protocols, or deployment details.
- Label assumptions and target-state elements.
- Keep diagrams consistent with written descriptions.
- Avoid diagrams that add visual complexity without answering a question.
- Use C4, arc42, UML, and ADR conventions pragmatically.

## Reference scenario

Document the Activity Retrieval Search Service: API entry, validation, structured/lexical/vector retrieval, geographic filtering, ranking, and response assembly. Distinguish confirmed implementation from a proposed target architecture.

## Evaluation

Use Architecture Documentation scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
