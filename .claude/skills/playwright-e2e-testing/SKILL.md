---
name: playwright-e2e-testing
description: Build, run, debug and review reliable Playwright browser tests with screenshots, traces and CI artifacts.
---
# Playwright E2E Testing
1. Inspect config, fixtures, conventions, and CI commands.
2. Map user journey to acceptance criteria.
3. Prefer role/label/placeholder locators; use test IDs when justified.
4. Assert observable behavior, not implementation details.
5. Isolate test data; avoid order dependencies.
6. Run focused tests, inspect failures, then relevant suite.
7. Capture traces/screenshots/video on failure per project policy.
8. Report command, browser, environment, result, artifact paths.
Reliability: no fixed sleeps; use condition-based waits and auto-waiting assertions; independent repeatable tests; no brittle selectors when accessible locators exist; retries diagnose flakiness, not hide it.
Evidence: screenshot meaningful checkpoints; trace on CI failure; keep originals unchanged; screenshot alone does not prove backend correctness; redact secrets and personal data.
Review: user-visible requirement? resilient locators? isolated data? cleanup? failure artifacts? local/CI reproducibility?
