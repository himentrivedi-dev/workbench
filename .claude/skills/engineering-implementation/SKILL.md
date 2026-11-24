---
name: engineering-implementation
description: Turn an agreed engineering change into a small, tested, reviewable implementation. Use when modifying code, APIs, data pipelines, or AI workflows.
---

# Engineering Implementation

## Workflow

1. Understand the task, acceptance criteria, repository instructions, and ownership.
2. Inspect repository status and relevant code before editing.
3. Identify dependencies, risks, and the smallest coherent implementation plan.
4. Confirm unclear or conflicting requirements before making irreversible changes.
5. Implement in small logical increments; preserve unrelated work.
6. Add or update unit, integration, contract, and evaluation tests as appropriate.
7. Run relevant checks and inspect the final diff.
8. Review security, error handling, observability, compatibility, and operational impact.
9. Report changed files, behaviour, checks run, checks not run, and follow-up risks.

## Output

- Understanding and assumptions
- Plan and acceptance criteria
- Implementation summary
- Tests and verification results
- Risks, limitations, and next steps

## Guardrails

- Follow repository-specific instructions and existing conventions.
- Do not claim tests passed unless they were run and passed.
- Do not overwrite user changes or broaden scope without agreement.
- Prefer deterministic logic for deterministic work.
- For AI changes, include representative eval cases and track quality, latency, and cost.
- Use the existing Git workflow skill for commits, branches, and parallel work.

## Reference scenario

Implement a retrieval API change that adds a preference signal. Preserve hard constraints, define ranking behaviour, add regression cases, and ensure the response contract remains compatible.

## Evaluation

Use Engineering Implementation scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
