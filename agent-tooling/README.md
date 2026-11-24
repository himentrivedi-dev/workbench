# Engineering Operating System

A practical, lightweight system for engineering work across individual contribution, technical leadership, and engineering management.

## Start here

1. [Engineering principles](standards/ENGINEERING_PRINCIPLES.md)
2. [Writing principles](standards/WRITING_PRINCIPLES.md)
3. [Review principles](standards/REVIEW_PRINCIPLES.md)
4. [Phased roadmap and acceptance gates](ROADMAP.md)
5. [How to test and iterate](evals/README.md)

## Claude Code skills

Project-level skills live in `.claude/skills/` so Claude Code can discover them when this repository is opened as the project.

| Skill | Use it for |
|---|---|
| [First Principles](../.claude/skills/first-principles/SKILL.md) | Frame problems and challenge assumptions |
| [Requirements Engineering](../.claude/skills/requirements-engineering/SKILL.md) | Define testable requirements and acceptance criteria |
| [Architecture Design](../.claude/skills/architecture-design/SKILL.md) | Compare options, boundaries, and trade-offs |
| [Engineering Implementation](../.claude/skills/engineering-implementation/SKILL.md) | Implement small, verified changes |
| [Engineering Quality](../.claude/skills/engineering-quality/SKILL.md) | Assess production quality and release readiness |
| [Technical Review](../.claude/skills/technical-review/SKILL.md) | Review PRs, designs, and production readiness |
| [Technical Writing](../.claude/skills/technical-writing/SKILL.md) | Write and review clear technical content |
| [Diátaxis Documentation](../.claude/skills/diataxis-documentation/SKILL.md) | Organise docs by reader need |
| [Architecture Documentation](../.claude/skills/architecture-documentation/SKILL.md) | Document systems, flows, decisions, and deployment |
| [Leadership Communication](../.claude/skills/leadership-communication/SKILL.md) | Communicate status, risks, and decisions |

The existing [Git workflow skill](skills/git-workflow/SKILL.md) remains in this library and is not replaced.

## How to use

- Open this repository as the Claude Code project. Invoke a skill by its name or describe the task; verify discovery in your installed Claude Code version.
- Use the smallest relevant skill. Do not chain all skills for a small task.
- Shared standards live here; skill-specific workflows live in `.claude/skills/`.
- Templates live in [templates](templates/). Evaluation cases and the scorecard live in [evals](evals/).
- The roadmap defines the build phases and exit gates.

## Design rules

- Keep each `SKILL.md` concise and task-focused.
- Load templates, examples, and detailed references only when needed.
- Do not duplicate shared principles.
- Require evidence for findings and label assumptions.
- Prefer deterministic software for deterministic work.
- A skill is not considered validated until it has been tested against a baseline.

## Add or change a skill

1. Define the behaviour it should improve.
2. Add normal, ambiguous, contradictory, negative, and out-of-scope cases as appropriate.
3. Compare baseline and skill-assisted outputs with the same model and context.
4. Score correctness, completeness, clarity, actionability, evidence, and efficiency.
5. Analyse failures, make the smallest change, and re-run regression cases.
6. Record the decision and limitations.

See [evaluation guide](evals/README.md) and [scorecard](evals/scorecard.md).
