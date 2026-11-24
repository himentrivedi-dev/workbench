---
name: requirements-engineering
description: Convert ambiguous product and engineering needs into structured, testable requirements, acceptance criteria, and traceability. Use before design or implementation when expected behaviour needs definition.
---

# Requirements Engineering

## Workflow

1. Capture problem, users, business outcome, scope, and non-goals.
2. Separate business, user, functional, data, interface, and quality requirements.
3. Distinguish hard constraints from preferences and ranking signals.
4. Identify ambiguity, contradiction, missing information, and assumptions.
5. Write atomic, unambiguous, feasible, verifiable requirements.
6. Add acceptance criteria using Given/When/Then where useful.
7. Cover negative paths, boundaries, failure behaviour, and permissions.
8. Map requirements to acceptance criteria and tests.
9. Review completeness and consistency with the requester.

## Output

- Problem and scope
- Stakeholders and user needs
- Business requirements
- Functional requirements
- Non-functional requirements with measurable targets or explicit TBDs
- User stories and acceptance criteria
- Edge cases and negative requirements
- Traceability matrix
- Open questions and assumptions

## Quality checks

Each requirement should be necessary, clear, singular, consistent, feasible, and verifiable. Avoid vague words such as fast, easy, robust, or intelligent unless they are defined by measurable criteria.

## Reference scenario

For AI Activity Search, interpret "something relaxing near the water." Do not assume exact distance, budget, date, or activity type. Separate user preference from hard constraints; define clarification behaviour, geographic relevance, result explanation, and no-result behaviour.

## Guardrails

- Do not invent values for missing thresholds.
- Preserve conflicts instead of silently choosing one side.
- Ask a focused question when missing information changes expected behaviour.
- Use ISO/IEC/IEEE 29148 and IREB CPRE as conceptual references, not claims of formal certification.

## Evaluation

Use Requirements Engineering scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
