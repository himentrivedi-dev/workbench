---
name: engineering-quality
description: Assess and improve production engineering quality across correctness, performance, reliability, security, scalability, observability, maintainability, and cost. Use for service reviews and release readiness.
---

# Engineering Quality

## Workflow

1. Identify service purpose, critical user journeys, dependencies, and risk.
2. Review quality attributes relevant to the system; do not apply every checklist mechanically.
3. Inspect implementation, tests, telemetry, incidents, SLOs, and deployment practices where available.
4. Separate measured evidence, design inference, and missing evidence.
5. Prioritise risks by likelihood, impact, and detectability.
6. Recommend measurable controls, tests, and operational improvements.
7. Define release gates and owners where risk warrants them.

## Quality dimensions

- Correctness and data integrity
- Performance: latency percentiles, throughput, saturation
- Reliability: availability, timeouts, retries, recovery, partial failure
- Security and privacy
- Scalability and capacity
- Observability: logs, metrics, traces, alerts
- Maintainability and change risk
- Cost per successful user outcome

For retrieval and AI systems, include Recall@K, MRR, nDCG, hard-constraint correctness, freshness, grounding, tool/planning success, latency, and cost where relevant.

## Output

- Scope and evidence
- Quality assessment by dimension
- Measured values versus unknowns
- Prioritised risks
- Recommended controls and tests
- Release readiness and residual risks

## Guardrails

- Never invent metrics, SLOs, or test results.
- Do not equate code coverage with correctness.
- Do not claim production readiness from a demo.
- Use ISO 25010, OWASP, Google SRE, OpenTelemetry, and AWS Well-Architected as reference frameworks where appropriate.

## Reference scenario

Assess an Activity Retrieval Search Service with structured, lexical, semantic, and geographic retrieval. Consider quality of ranking, hard constraints, data freshness, p95 latency, availability, observability, security, and cost per successful search. Mark unavailable evidence as a gap.

## Evaluation

Use Engineering Quality scenarios in `agent-tooling/evals/cases/SCENARIOS.md` and the shared scorecard.
