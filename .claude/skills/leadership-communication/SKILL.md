---
name: leadership-communication
description: Turn complex engineering work into concise, decision-oriented updates for leadership and stakeholders. Use for status reports, risks, escalations, proposals, and decision requests.
---

# Leadership Communication

## Workflow

1. Identify audience, decision rights, and purpose.
2. Lead with outcome, status, or decision required.
3. Explain customer/business impact before implementation detail.
4. Summarise progress, next milestone, risks, dependencies, and owners.
5. Separate confirmed facts, estimates, assumptions, and forecasts.
6. Make any requested decision explicit, including owner and deadline.
7. Check that simplification has not removed material technical risk.

## Output

Use the template in `agent-tooling/templates/leadership-update.md` when appropriate. For shorter requests, use:
- Headline/status
- Outcome or impact
- Risk/dependency
- Next action/owner
- Decision needed

## Guardrails

- Do not hide a material risk to make an update sound positive.
- Do not use unexplained engineering jargon.
- Do not present estimates as commitments.
- Do not blame individuals; describe conditions, impact, and corrective action.
- Keep detail available as a linked appendix when needed.

## Reference scenario

Explain a latency regression in an AI activity search workflow. State what is measured, customer impact, likely causes versus confirmed cause, mitigation, owner, and next update. Do not claim root cause until verified.

## Evaluation

Use Leadership Communication scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
