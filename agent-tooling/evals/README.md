# Skill Evaluation and Iteration

This guide defines how to test whether a skill improves real engineering work. A skill is an experiment until it demonstrates repeatable value.

## 1. Establish a baseline

For each test case, run the same task twice:
- **Baseline:** Claude Code without the target skill active.
- **Skill run:** The same model, task, source material, and constraints with the skill active.

Keep model/version, relevant context, tools, and task wording constant where practical. Record unavoidable differences.

Do not compare two runs if one had materially more source context or access to tools.

## 2. Use representative test cases

Each skill should have 5–10 cases at minimum. Include:
- Normal, common task
- Ambiguous or incomplete input
- Contradictory requirements or constraints
- Negative case where the right action is to question or refuse an assumption
- Complex or high-impact case
- A case where the skill should not be invoked, where applicable

Start with the scenario catalogue in `cases/SCENARIOS.md`. Add domain-specific cases as real work exposes gaps. Use anonymised data.

## 3. Score outputs

Score each dimension from 1 to 5. Use the same rubric for baseline and skill runs.

| Dimension | 1 | 3 | 5 |
|---|---|---|---|
| Correctness | Material errors | Mostly correct; minor gaps | Correct and supported |
| Completeness | Misses core needs | Covers main needs | Covers relevant edge cases |
| Clarity | Hard to follow | Understandable | Direct, structured, audience-fit |
| Actionability | No useful next step | Some actions | Specific, prioritised, verifiable |
| Evidence and uncertainty | Invents or overstates | Some caveats | Separates facts, assumptions, unknowns |
| Efficiency | Excessive or incomplete | Acceptable | Concise without losing needed detail |

Not every dimension applies equally to every skill. Mark a dimension N/A only with a short reason.

## 4. Track operational cost

Record:
- Input and output tokens when available
- Time to complete
- Number of tool calls or manual follow-ups
- Human correction effort
- Rework caused by incorrect or missing output

Do not optimise tokens at the expense of correctness or safety.

## 5. Decide whether the skill helped

A skill is worth keeping when it:
- Improves correctness, completeness, clarity, or actionability on relevant cases.
- Does not create a material regression in another important dimension.
- Does not add disproportionate latency, token cost, or maintenance burden.
- Behaves sensibly on ambiguous and out-of-scope tasks.

Initial suggested acceptance rule:
- No critical correctness or safety failures.
- Average score improves by at least 0.5 on the primary dimensions across the case set, **or** a documented high-impact failure is prevented.
- No important dimension drops by more than 0.5 without an accepted reason.
- Human corrections and cost are not materially worse.

These are starting thresholds, not universal benchmarks. Adjust them after collecting a few evaluation cycles and record the rationale.

## 6. Iterate using failure analysis

For every failed or weak case, record:
1. Expected behaviour
2. Actual behaviour
3. Evidence from the output
4. Root cause category
5. Smallest proposed change
6. Regression cases to re-run

Root cause categories:
- Missing or unclear skill instruction
- Missing shared principle or reference
- Missing task context
- Weak or misleading example
- Missing evaluation case
- Tool or environment limitation
- Model capability or variability
- User request ambiguity

Do not add a new rule for every individual failure. Look for recurring patterns and solve the underlying cause.

## 7. Version and regression policy

- Keep a dated evaluation run log.
- Preserve representative cases when changing a skill.
- Re-run all cases for the changed skill.
- Re-run cross-skill cases when shared standards change.
- Record skill revision, model, date, scores, regressions, and decision.
- Retire redundant instructions and stale examples.

## 8. Human review

For high-impact architecture, security, production, or people-related decisions, human review remains required. Skill evaluation measures assistance quality; it does not grant decision authority.
