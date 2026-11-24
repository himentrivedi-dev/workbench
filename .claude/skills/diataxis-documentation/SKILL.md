---
name: diataxis-documentation
description: Organise product and developer documentation by reader need using the Diátaxis tutorial, how-to, explanation, and reference types. Use when creating, restructuring, or auditing documentation.
---

# Diátaxis Documentation

## Classify by reader need

- **Tutorial:** learning-oriented; guides a beginner through a successful experience.
- **How-to guide:** task-oriented; helps a reader solve a specific problem.
- **Explanation:** understanding-oriented; explains concepts, context, and reasons.
- **Reference:** information-oriented; provides accurate facts about interfaces and behaviour.

## Workflow

1. Identify reader, task, and current knowledge.
2. Classify each content unit by its primary purpose.
3. Separate mixed content into the appropriate documentation types.
4. Check prerequisites, sequence, expected results, and terminology.
5. Keep reference material precise and complete; keep explanations conceptual.
6. Link related documents instead of duplicating content.
7. Audit navigation, freshness, examples, and broken references.

## Output

- Document inventory and classification
- Proposed information architecture
- Content gaps and duplication
- Restructuring recommendations
- Quality checklist

## Guardrails

- Do not force every small project to create four documents when some types are not needed.
- A document may link to another type; avoid mixing purposes in the same section.
- Tutorials must be tested by a reader following the steps.
- Reference content must match the actual interface or implementation.

## Reference scenario

For an Activity Retrieval API, create a tutorial for a first integration, a how-to for authentication or filtering, an explanation of semantic retrieval, and a reference for endpoints, parameters, schemas, and error codes.

## Evaluation

Use Diátaxis scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
