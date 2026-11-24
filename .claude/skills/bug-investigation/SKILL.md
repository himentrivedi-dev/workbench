---
name: bug-investigation
description: Investigate and fix software defects using an adaptive, evidence-led workflow. Use when diagnosing a bug, regression, flaky behaviour, or production incident.
---

# Bug Investigation

## Operating principle

Find the cause before changing code. Scale investigation effort to the defect's complexity, impact, and uncertainty. A simple, reproducible defect should stay simple; a high-impact or poorly understood defect deserves deeper investigation.

## Workflow

1. **Understand the symptom**
   - Capture expected versus actual behaviour, affected users/flows, environment, frequency, and impact.
   - Identify recent changes and relevant logs, traces, metrics, inputs, and dependencies.
   - Separate observed facts from assumptions.

2. **Reproduce and narrow**
   - Reproduce the issue when practical.
   - Create the smallest failing example or test.
   - If it is intermittent or production-only, preserve evidence and state what cannot yet be reproduced.

3. **Find the root cause**
   - Trace the failing behaviour through the relevant code and data boundaries.
   - For a straightforward defect, test the most likely cause directly.
   - For complex or ambiguous defects, form a small ranked set of hypotheses (typically 2–4), then use targeted evidence to eliminate or confirm them.
   - Change one explanatory variable at a time. Do not confuse correlation with cause.

4. **Choose the smallest safe fix**
   - Correct the underlying cause rather than masking the symptom.
   - Consider compatibility, data integrity, concurrency, retries, timeouts, and failure propagation where relevant.
   - Avoid unrelated refactoring. If the evidence points to a broader design issue, explain it separately.

5. **Prevent regression**
   - Add or update a test that fails before the fix and passes after it.
   - Prefer a test of externally observable behaviour or the relevant contract over a test coupled to implementation details.
   - For flaky defects, test the triggering condition and avoid introducing timing-sensitive tests without justification.

6. **Verify and report**
   - Re-run the focused regression test and relevant broader checks.
   - Inspect the final diff for unintended changes.
   - State what was verified, what was not run, residual uncertainty, and any follow-up monitoring needed.

## Adaptive depth

| Situation | Appropriate depth |
|---|---|
| Small, deterministic, local defect | Reproduce, inspect cause, minimal fix, regression test, focused verification |
| Unclear or intermittent defect | Capture evidence, narrow the case, test ranked hypotheses, add regression coverage |
| Production-impacting or cross-service defect | Assess impact and containment, trace dependencies and state transitions, examine partial failure/recovery, verify operational signals |
| Repeated failed fixes or recurring defect | Revisit the causal model and architecture; do not keep layering patches |

Do not force a fixed number of hypotheses, tools, agents, or investigation steps. Escalate when impact, uncertainty, or repeated failure justifies it.

## Guardrails

- Do not edit code before understanding the failure unless an urgent, clearly bounded mitigation is required.
- Do not claim root cause when only a plausible explanation has been found.
- Do not hide errors with broad catches, silent fallbacks, or retries that erase useful failure signals.
- Do not remove a failing test merely to make the suite pass.
- Do not claim a fix is verified unless the relevant checks were actually run.
- Keep debugging instrumentation temporary unless it is intentionally retained as useful observability.

## Output

- Symptom and impact
- Reproduction or evidence, including limitations
- Confirmed cause or ranked hypotheses
- Fix and regression test
- Verification performed and not performed
- Residual risk or follow-up

## Evaluation

Use Bug Investigation scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard. Compare baseline and skill-assisted runs; do not mark the skill validated from illustrative examples alone.
