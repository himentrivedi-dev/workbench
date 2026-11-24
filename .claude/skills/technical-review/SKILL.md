---
name: technical-review
description: Review pull requests, technical designs, and AI system proposals for evidence-backed correctness, risk, and maintainability. Use before merge, design approval, or production release.
---

# Technical Review

## Modes

- **Pull Request Review:** inspect changed code, tests, contracts, and regressions.
- **Architecture Challenge:** assess problem fit, boundaries, alternatives, and trade-offs.
- **Production Readiness:** assess operational, security, reliability, quality, and recovery gaps.

## Workflow

1. Confirm objective, scope, requirements, and review context.
2. Inspect the actual artefacts and relevant tests. Do not infer unseen code.
3. Trace important flows and identify boundary, state, and failure behaviour.
4. Evaluate correctness, security, reliability, performance, compatibility, maintainability, and cost as relevant.
5. For AI systems, inspect intent interpretation, retrieval, grounding, planning, tool selection, execution, context, evaluation, and recovery.
6. Report findings using Observation → Evidence → Impact → Recommendation.
7. Assign severity using `agent-tooling/standards/REVIEW_PRINCIPLES.md`.
8. State checks run, checks not run, assumptions, and approval conditions.

## Output

- Scope and evidence inspected
- Overall assessment
- Findings ordered by severity, with location and reproducible evidence
- Questions and risks to validate
- Tests/checks run and not run
- Required actions and approval conditions

## Guardrails

- Report defects, not personal preferences.
- Never invent a finding or imply an unrun test passed.
- Distinguish confirmed defects from questions and risks.
- Severity reflects impact and likelihood.
- Be constructive; critique the change, not its author.

## Reference scenario

Review a dynamic travel planner that creates a DAG at runtime. Challenge whether single-domain requests need full planning, whether tool dependencies are explicit, and how timeouts, partial completion, retries, and recovery work. Require evidence before claiming the design is defective.

## Evaluation

Use Technical Review scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
