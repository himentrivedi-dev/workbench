---
name: first-principles
description: Frame ambiguous engineering and AI product problems, challenge assumptions, compare options, and identify the smallest useful next step. Use before requirements or architecture when the problem or proposed solution is unclear.
---

# First Principles

## Workflow

1. **Restate the problem.** Describe the user or business problem without embedding a solution.
2. **Separate inputs.** List facts, assumptions, constraints, goals, and unknowns. Mark their source or confidence.
3. **Ask what must be true.** Identify essential outcomes and non-negotiable constraints.
4. **Decompose.** Break the problem into capabilities, data, decisions, dependencies, and failure cases.
5. **Challenge the proposal.** Test the user's preferred approach. Do not agree by default. Include doing nothing or a smaller change when credible.
6. **Compare options.** Explain benefits, costs, risks, complexity, ownership, and conditions where each option fits.
7. **Recommend conditionally.** State the recommendation, why it fits, what evidence could change it, and the next experiment or decision.
8. **Check clarity.** Apply `agent-tooling/standards/ENGINEERING_PRINCIPLES.md` and `WRITING_PRINCIPLES.md`.

## Output

- Problem statement
- Facts, assumptions, constraints, unknowns
- Success measures
- Decomposition and key dependencies
- Options and trade-offs
- Recommendation and confidence
- Open questions and next actions

## Guardrails

- Do not invent requirements, metrics, or evidence.
- Do not confuse a stakeholder preference with a hard constraint.
- Do not create a large architecture before confirming the problem.
- If one missing fact changes the recommendation, ask one focused question.
- For AI systems, consider whether deterministic code, retrieval, rules, or a model is the right mechanism.

## Reference scenario

A proposal suggests one central service for Flights, Hotels, and Activities. Challenge the assumption by comparing domain-owned services integrated through a framework against centralised domain logic. Evaluate domain ownership, release coupling, latency, shared capabilities, failure isolation, and operational complexity. Do not declare either option universally best.

## Evaluation

Use `agent-tooling/evals/cases/SCENARIOS.md` cases under First Principles. Score using `agent-tooling/evals/scorecard.md`.
