# Pull Request Review Checklist

Use this checklist alongside the [PR Description Standard](PR_DESCRIPTION_STANDARD.md) and the repository [Review Principles](../../../agent-tooling/standards/REVIEW_PRINCIPLES.md).

## Before reviewing

- [ ] Understand the problem, intended behaviour, and scope.
- [ ] Read the PR description and linked requirements/design/incident.
- [ ] Check that the diff matches the stated intent.
- [ ] Identify affected interfaces, data, consumers, and operational paths.

## Review the change

- [ ] Correctness: normal, boundary, failure, and retry paths are handled.
- [ ] Compatibility: API, schema, configuration, and consumer impacts are understood.
- [ ] Security and privacy: trust boundaries, access, secrets, and personal data are handled safely.
- [ ] Reliability: timeouts, retries, idempotency, fallbacks, and partial failures are considered.
- [ ] Performance and cost: likely latency, scale, and resource impacts are acceptable.
- [ ] Observability: useful logs, metrics, and alerts exist without exposing sensitive data.
- [ ] Tests: meaningful automated tests cover the change and regression risks.
- [ ] Maintainability: implementation is understandable and avoids unnecessary complexity.
- [ ] Documentation: operational and developer-facing guidance is updated where needed.

## For AI-enabled changes, where applicable

- [ ] Input ambiguity and interpretation are tested.
- [ ] Retrieval relevance, freshness, ranking, and grounding are evaluated.
- [ ] Tool selection, planning, dependencies, and execution are correct.
- [ ] Context limits, data boundaries, and unsupported outputs are handled.
- [ ] Evaluation evidence covers representative and failure scenarios.
- [ ] Latency, reliability, and cost are measured where material.

## Review outcome

- [ ] Findings are specific, evidence-based, and ordered by impact.
- [ ] Each finding explains its consequence and gives an actionable next step.
- [ ] Questions and unverified risks are not presented as confirmed defects.
- [ ] Approval does not imply that unrun tests or unchecked areas passed.
- [ ] Required changes and remaining limitations are explicit.

For severity definitions and review-comment guidance, follow the repository [Review Principles](../../../agent-tooling/standards/REVIEW_PRINCIPLES.md).
