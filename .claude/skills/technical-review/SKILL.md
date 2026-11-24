---
name: technical-review
description: Review pull requests, technical designs, and AI system proposals for requirement compliance, engineering quality, and evidence-backed risk. Use before merge, design approval, or production release.
---

# Technical Review

## Review model

For a pull request, assess two independent dimensions. Do not let strength in one hide a failure in the other.

1. **Specification and behaviour:** Does the change solve the stated problem and satisfy requirements, acceptance criteria, API contracts, user-visible behaviour, and relevant edge cases?
2. **Engineering standards and quality:** Is the implementation correct, secure, reliable, maintainable, observable, performant, compatible, and proportionate to the problem?

A change can be technically elegant but solve the wrong problem; it can also meet the requirement while introducing unsafe or costly engineering. Report each dimension separately.

## Workflow

1. **Establish context**
   - Confirm the PR objective, ticket/specification, acceptance criteria, constraints, and out-of-scope items.
   - Inspect the exact base-to-head diff and relevant surrounding code. Use the repository's standards and conventions.
   - If a requirement or source of truth is missing, state the gap rather than inventing intent.

2. **Run the primary review**
   - Check specification/behaviour compliance independently from engineering quality.
   - Trace affected paths, interfaces, state transitions, data changes, and failure behaviour.
   - Inspect tests for behavioural coverage, not only line coverage. Look for meaningful boundary, negative, error, concurrency, and regression cases where relevant.
   - Consider security, privacy, compatibility, observability, performance, and operational impact in proportion to the change.

3. **Add specialist review only when justified**
   - Security: authentication, authorisation, secrets, sensitive data, trust boundaries, or new attack surface.
   - Testing: critical workflows, complex state, concurrency, async behaviour, or weak regression coverage.
   - Error handling: catches, fallbacks, retries, partial results, swallowed exceptions, or failure propagation.
   - Performance: hot paths, high-volume data, fan-out, expensive model/tool calls, or latency-sensitive changes.
   - Types/data/API: schema, contract, migration, compatibility, or data-integrity changes.
   - Architecture: broad refactors, new service boundaries, orchestration, or significant dependency changes.
   - Use one primary reviewer by default. Do not launch every specialist for every PR; avoid duplicate reviews and low-value parallelism.

4. **Validate findings**
   - Report a defect only when supported by changed code, a requirement, a test, or reproducible evidence.
   - Distinguish confirmed defects from questions, risks, and optional improvements.
   - Give file/line references where available and explain impact and a practical correction.
   - Calibrate severity using `agent-tooling/standards/REVIEW_PRINCIPLES.md`.

5. **Conclude with an actionable assessment**
   - State checks run and not run; never imply an unrun check passed.
   - Summarise blockers, required changes, open questions, and residual risks.
   - Leave the merge decision to the responsible human reviewer.

## Output

- **Specification / behaviour:** Pass, concerns, or not assessable; explain against the stated requirements.
- **Engineering quality:** Pass, concerns, or not assessable; explain the material risks.
- **Findings:** Severity, location, evidence, impact, recommendation.
- **Questions / risks:** Unconfirmed concerns that need validation.
- **Verification:** Tests and checks run, not run, and important coverage gaps.
- **Recommendation:** Required before merge, follow-up, or no material issue found.

## Guardrails

- Review the change, not the author.
- Prefer high-confidence, actionable findings over comment volume.
- Do not report personal style preferences as defects unless they violate an agreed standard or impair clarity.
- Do not assume tests passed because they exist or because CI status is unavailable.
- Do not treat every code smell, missing test, or theoretical concern as a blocker; assess context and impact.
- Do not approve solely because no issue was noticed in a limited review.

## Other review modes

For architecture challenge or production readiness, adapt the same evidence-first principles to problem fit, boundaries, alternatives, operational controls, and recovery. Do not force PR-specific checks onto unrelated reviews.

## Evaluation

Use Technical Review scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard. Compare baseline and skill-assisted runs before claiming measurable improvement.
