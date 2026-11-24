# Review Principles

A technical review should reduce risk and improve the work. It should not reward personal preference or produce a long list of low-value comments.

Apply these principles to pull requests, technical designs, architecture proposals, and production-readiness reviews.

## 1. Review against an explicit objective

Understand:

- What problem is the change intended to solve?
- What behaviour or decision is expected?
- Which requirements and constraints apply?
- What is in scope and out of scope?
- Which tests or evidence support the change?

If the objective is unclear, ask for clarification before making assumptions.

## 2. Prioritise impact over preference

Look for issues that affect:

- Correctness or data integrity
- Security or privacy
- Reliability and failure recovery
- Performance or scalability
- API and data compatibility
- Maintainability and operational support
- Cost or resource use
- Requirements and user experience

Do not report formatting or stylistic preferences as defects unless they violate an agreed standard or make the code harder to understand.

## 3. Support every finding with evidence

Use this structure:

**Observation → Evidence → Impact → Recommendation**

- Observation: describe the specific issue.
- Evidence: point to code, a requirement, a trace, a metric, or a reproducible case.
- Impact: explain the likely consequence.
- Recommendation: suggest a practical correction or a question that resolves the uncertainty.

If evidence is missing, label the concern as a question or risk to validate. Do not present it as a confirmed defect.

## 4. Use consistent severity

| Severity | Meaning | Expected response |
|---|---|---|
| Critical | Severe security, data-loss, or system-wide failure risk | Block release until resolved |
| High | Major correctness, security, reliability, or user-impacting issue | Resolve before merge or release |
| Medium | Meaningful defect or maintainability risk with limited scope | Fix or explicitly accept before completion |
| Low | Small improvement with limited impact | Optional or follow-up |
| Informational | Clarification or useful context; no defect asserted | No action required unless useful |

Severity must reflect impact and likelihood, not how strongly the reviewer feels about the issue.

## 5. Be constructive and precise

- Critique the change, not the author.
- Explain why a change matters.
- Ask a focused question when intent is uncertain.
- Offer a practical next step.
- Acknowledge sound decisions when that helps explain the review.
- Avoid sarcasm, blame, vague warnings, and absolute claims without evidence.

## 6. Review AI-enabled behaviour explicitly

Where relevant, inspect:

- Input interpretation and ambiguity handling
- Retrieval relevance, recall, ranking, and freshness
- Grounding and unsupported claims
- Model and tool selection
- Planning and dependency handling
- Execution correctness and idempotency
- Context limits and data boundaries
- Timeouts, retries, fallbacks, and partial results
- Evaluation coverage, latency, and cost

Use representative test cases and measured results. Do not infer production quality from a successful demonstration.

## 7. Separate findings from approval

A review should state:

1. Overall assessment
2. Findings ordered by severity
3. Questions or risks that need validation
4. Required changes, if any
5. Tests and evidence inspected
6. Important gaps or checks not performed

Do not imply that unrun tests passed. Do not approve a change solely because no issue was noticed in a limited review.

## Review quality checklist

- Is each finding specific and reproducible?
- Does each finding include evidence?
- Is the impact clear?
- Is severity proportionate?
- Is the recommendation actionable?
- Have assumptions and unknowns been labelled?
- Have positive design choices and trade-offs been considered?
- Are unverified areas stated honestly?
