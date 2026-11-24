# Writing Principles

Write so that a reader can understand the message, take the right action, and verify the technical meaning.

These principles are inspired by the clarity goals of ASD-STE100 and established technical-writing guidance. They are not a claim of formal ASD-STE100 compliance. Use controlled-language techniques where they improve clarity; do not force a restricted vocabulary when it makes technical content less accurate.

## 1. Start with the reader's need

Before writing, identify:

- Audience: engineering, leadership, product, operations, or a mixed group.
- Purpose: inform, explain, instruct, request a decision, or provide a reference.
- Reader action: what should the reader know or do after reading?

## 2. Use clear, direct language

- Prefer common words over unnecessary jargon.
- Prefer active voice when the actor matters.
- Use one main idea per sentence.
- Keep paragraphs focused.
- Use headings that describe the content.
- Expand an acronym on first use unless it is familiar to the intended audience.
- Define domain-specific terms when readers may interpret them differently.

## 3. Preserve technical meaning

- Do not simplify away constraints, conditions, exceptions, or uncertainty.
- Keep identifiers, API names, code, formulas, and protocol terms exact.
- Separate facts from assumptions, proposals, and decisions.
- Do not turn estimates into commitments.
- Do not invent missing details to make a document sound complete.

## 4. Make information easy to scan

- Put the main conclusion or action near the beginning.
- Use lists for steps or related items.
- Use tables for direct comparisons, structured fields, and decision summaries.
- Use diagrams when they explain relationships or flows better than prose.
- Keep examples close to the concept they explain.
- Link to the source of truth instead of copying large sections.

## 5. Adapt the level of detail

| Audience | Emphasise | Avoid |
|---|---|---|
| Engineering team | Behaviour, interfaces, data, edge cases, operations, and examples | Vague statements and missing contracts |
| Technical leadership | Options, trade-offs, risks, dependencies, impact, and decisions needed | Low-level detail without a decision context |
| Non-technical stakeholders | User or business impact, status, risk, and next action | Unexplained acronyms and implementation detail |

A document can serve more than one audience, but it should make the intended reader and purpose clear.

## 6. Write instructions that can be followed

For procedures:

1. State when the procedure applies.
2. List prerequisites.
3. Use numbered steps in execution order.
4. Give expected results where useful.
5. Explain recovery or escalation for important failure cases.

## 7. Review before publishing

Check that:

- The purpose and audience are clear.
- The main point appears early.
- Sentences are direct and unambiguous.
- Terms are used consistently.
- Requirements and instructions are testable or actionable.
- Examples match the described behaviour.
- Links and references are relevant.
- No unsupported claim has been added.
- The document preserves the source's technical meaning.

## Practical rule

Use the simplest wording that preserves the full meaning. Clarity is not the same as removing necessary detail.
