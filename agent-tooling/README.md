# Engineering Operating System

A lightweight set of principles, workflows, and Claude Code skills for engineering work across individual contribution, technical leadership, and engineering management.

The aim is not to add process for its own sake. It is to make technical work more reliable and communication easier to understand.

## Start here

1. [Engineering principles](standards/ENGINEERING_PRINCIPLES.md) — how to frame problems, make decisions, and deliver systems.
2. [Writing principles](standards/WRITING_PRINCIPLES.md) — how to write clearly without losing technical meaning.
3. [Review principles](standards/REVIEW_PRINCIPLES.md) — how to give evidence-based, constructive technical feedback.

## Existing skills

- [Git workflow](skills/git-workflow/SKILL.md) — safe, incremental Git operations and parallel-work integration.

## Planned skill areas

Skills will be added incrementally and evaluated against realistic work before they become part of the standard workflow.

| Area | Intended capabilities |
|---|---|
| Thinking | First-principles problem framing and assumption testing |
| Definition | Requirements analysis and acceptance criteria |
| Design | Architecture options, trade-offs, and decision records |
| Delivery | Implementation, testing, and engineering quality |
| Review | PR, architecture, and production-readiness reviews |
| Documentation | Technical writing, Diátaxis, and architecture documentation |
| Leadership | Clear status, decision, risk, and stakeholder communication |

## Design rules

- Keep each `SKILL.md` focused on when to use it, its workflow, expected output, and quality checks.
- Put detailed standards, examples, and templates in separate files. Load them only when needed.
- Prefer deterministic tools and checks for work they can perform reliably.
- Require evidence for findings and explicit assumptions for uncertain conclusions.
- Test skills against representative tasks. Keep a skill only when it improves correctness, clarity, completeness, or efficiency.
- Avoid duplicating shared principles across skills.

## How to add a skill

1. State the problem the skill solves and when it should be used.
2. Define the minimum useful workflow and output contract.
3. Link to relevant standards instead of copying them into the skill.
4. Add representative positive, negative, and ambiguous evaluation cases.
5. Compare results with and without the skill.
6. Record limitations and maintenance ownership.

This directory is the source library. Claude Code discovery and installation conventions should be handled explicitly when the skill set is ready; do not assume every file under this directory is automatically loaded by Claude Code.
