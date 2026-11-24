# Example Evaluation Run — Illustrative Only

This file demonstrates how to record a comparison. The values below are placeholders, not measured results.

## Task

Rewrite a technical description of an Activity Retrieval Search Service for an engineering audience.

## Controlled setup

- Use the same model and task wording.
- Provide the same source description to both runs.
- Baseline: do not activate the technical-writing skill.
- Skill run: activate technical-writing.
- Do not add extra facts to either run.

## What to compare

| Dimension | Review question |
|---|---|
| Correctness | Did both versions preserve retrieval stages, constraints, and behaviour? |
| Completeness | Did either omit important dependencies or failure cases? |
| Clarity | Can an engineer understand the flow on first reading? |
| Actionability | Does the reader know what to inspect or do next? |
| Evidence | Are uncertain implementation details labelled? |
| Efficiency | Is the text concise without losing necessary detail? |

## Example findings format

- **Observed difference:** <quote or identify the exact output behaviour>
- **Why it matters:** <reader impact>
- **Score impact:** <dimension and reason>
- **Likely cause:** <instruction, context, example, or model>
- **Next change:** <smallest proposed improvement>

## Decision

Do not conclude that the skill is better based on one example. Repeat across the skill's full case set and inspect regressions.
