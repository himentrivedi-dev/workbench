---
name: technical-writing
description: Draft, rewrite, simplify, and review technical content for engineering, leadership, and mixed audiences while preserving technical meaning. Use for design docs, API docs, updates, explanations, and procedures.
---

# Technical Writing

## Workflow

1. Identify audience, purpose, reader knowledge, and desired action.
2. Identify source material and distinguish facts, assumptions, decisions, and estimates.
3. Organise content around the reader's task; put the main point first.
4. Write direct sentences with common words. Define necessary jargon and acronyms.
5. Use lists for steps, tables for comparisons, and diagrams when they clarify relationships.
6. Preserve conditions, constraints, exceptions, identifiers, and uncertainty.
7. Review for accuracy, ambiguity, consistency, completeness, and actionability.
8. Apply `agent-tooling/standards/WRITING_PRINCIPLES.md`.

## Audience adaptation

- **Engineering:** behaviour, contracts, data, edge cases, operational details, examples.
- **Technical leadership:** outcomes, options, trade-offs, risks, dependencies, decisions.
- **Non-technical:** user/business impact, status, risk, and next action; explain technical terms.

## Output

Provide the requested artifact. When reviewing existing text, summarise material changes and flag any source ambiguity rather than silently resolving it.

## Guardrails

- ASD-STE100 is an inspiration for clarity, not a claim of compliance. Do not force restricted vocabulary.
- Never simplify away a technical condition or change the meaning.
- Do not add plausible but unsupported details.
- Preserve code, API identifiers, schema fields, formulas, and product terminology exactly.
- If the source is contradictory, surface the contradiction.

## Reference scenario

Rewrite a jargon-heavy summary of an Activity Retrieval Service for (a) engineers, (b) technical leadership, and (c) a non-technical stakeholder. Keep the same facts in all three versions; change only emphasis and explanation depth.

## Evaluation

Use the Technical Writing cases in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
