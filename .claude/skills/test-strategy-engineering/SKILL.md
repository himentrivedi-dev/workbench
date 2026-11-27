---
name: test-strategy-engineering
description: Create risk-based test strategies, test plans, coverage models and release validation plans.
---
# Test Strategy Engineering
Choose the smallest test set that gives credible confidence against the highest risks. Coverage percentage alone is not quality.
1. Understand change, users, architecture, dependencies, and impact radius.
2. Identify business, data, security, integration, performance, availability, and compatibility risks.
3. Convert requirements/risks into uniquely identified test conditions.
4. Select unit, integration, contract, API, UI/E2E, performance, security, and operational tests.
5. Define data, environment, preconditions, expected outcome, and evidence.
6. Prioritize by impact × likelihood × exposure; record rationale.
7. Execute and record actual results; a test existing is not a pass.
8. Summarize coverage, failures, blockers, residual risks, and release recommendation.
Use equivalence partitions, boundaries, decision tables, state transitions, pairwise combinations, negative and exploratory testing.
Scenario classes: happy path; invalid/boundary input; authn/authz; duplicate/replay/idempotency; dependency failure/timeout; concurrency; persistence; compatibility/regression; observability/recovery.
Output: ID | requirement/risk | preconditions | steps | expected | priority | test level | evidence.
Distinguish PASS, FAIL, BLOCKED, SKIPPED, NOT RUN, N/A. Explain uncovered areas.
