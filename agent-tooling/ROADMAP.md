# Engineering Operating System Roadmap

This roadmap covers the skills and working practices discussed for an Engineering Manager, Team Lead, and Individual Contributor working on AI-enabled products.

The phases are an adoption sequence, not a requirement to build everything before using anything. Each phase has a usable outcome and an evaluation gate.

## Scope map

| Capability | Skill location | Main outcome | Phase |
|---|---|---|---|
| First-principles problem solving | `.claude/skills/first-principles/SKILL.md` | Clear problem framing and challenged assumptions | 1 |
| Technical writing | `.claude/skills/technical-writing/SKILL.md` | Clear, accurate, audience-aware documents | 1 |
| Technical review | `.claude/skills/technical-review/SKILL.md` | Evidence-based design and PR reviews | 1 |
| Leadership communication | `.claude/skills/leadership-communication/SKILL.md` | Decision-oriented updates for stakeholders | 1 |
| Requirements engineering | `.claude/skills/requirements-engineering/SKILL.md` | Testable requirements and traceability | 2 |
| Architecture design | `.claude/skills/architecture-design/SKILL.md` | Alternatives, boundaries, trade-offs, decisions | 2 |
| Engineering implementation | `.claude/skills/engineering-implementation/SKILL.md` | Small, verified delivery increments | 2 |
| Engineering quality | `.claude/skills/engineering-quality/SKILL.md` | Measurable production quality | 2 |
| Diátaxis documentation | `.claude/skills/diataxis-documentation/SKILL.md` | Documentation organised by reader need | 3 |
| Architecture documentation | `.claude/skills/architecture-documentation/SKILL.md` | C4, ADR, flows, interfaces and deployment views | 3 |
| Git workflow | Existing `agent-tooling/skills/git-workflow/` | Safe incremental Git and parallel work | Existing |

## Phase 1 — Personal working foundation

**Build:** First Principles, Technical Writing, Technical Review, Leadership Communication.

**Why first:** These skills support daily work across individual contribution, team leadership, and management. They improve how problems are framed, work is challenged, and decisions are communicated.

**Exit gate:**
- Each skill has at least five representative evaluation cases.
- Outputs are factually sound and more useful than the no-skill baseline.
- Findings distinguish evidence from assumptions.
- Writing preserves technical meaning and suits the audience.
- No critical regression is introduced.

## Phase 2 — Engineering definition and delivery

**Build:** Requirements Engineering, Architecture Design, Engineering Implementation, Engineering Quality.

**Why second:** These skills make the engineering lifecycle more repeatable—from an ambiguous request to a tested, production-aware implementation.

**Exit gate:**
- Requirements are testable and traceable to acceptance criteria.
- Architecture reviews compare viable alternatives and state trade-offs.
- Implementation plans include tests, verification and rollback/recovery where relevant.
- Quality claims are tied to evidence and measurable indicators.

## Phase 3 — Documentation system

**Build:** Diátaxis Documentation and Architecture Documentation.

**Why third:** These skills establish a coherent documentation system after the core engineering and review practices exist.

**Exit gate:**
- Documents have an explicit audience and purpose.
- Tutorials, how-to guides, explanations and references are not mixed without reason.
- Architecture views agree with the actual system and link to decisions.
- Stale or unsupported statements are identified.

## Phase 4 — Continuous improvement

This is not another skill-building phase. It is the ongoing operating loop.

1. Run the evaluation suite against a fixed baseline.
2. Inspect failures and human corrections.
3. Identify whether the cause is missing context, unclear instructions, a weak template, or a model limitation.
4. Make the smallest targeted change.
5. Re-run the full relevant suite, not only the failing example.
6. Compare quality, token use, latency, and maintenance cost.
7. Keep, revise, or retire the change.

## Ownership and maintenance

- Treat the standards in `agent-tooling/standards/` as shared policy.
- Treat each `SKILL.md` as a focused workflow, not a copy of the standards.
- Keep examples and evaluation cases in `agent-tooling/evals/`.
- Update the roadmap when a skill changes status.
- Do not label a skill production-ready until it has passed its evaluation gate.

## What this is not

- It is not a mandatory process for every small task.
- It is not a collection of prompts that blindly agree with the user.
- It is not a replacement for engineering judgement, domain experts, tests, or production evidence.
- It does not guarantee Claude Code will discover files outside its configured skill locations. The skill files are placed in the project-level `.claude/skills/` directory for project discovery; shared standards and evaluations remain in `agent-tooling/`.
