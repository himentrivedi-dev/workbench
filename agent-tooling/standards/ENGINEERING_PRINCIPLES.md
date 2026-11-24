# Engineering Principles

These principles guide problem framing, technical design, implementation, and engineering decisions. They apply across individual contribution, team leadership, and engineering management.

## 1. Understand the problem before choosing a solution

- State the user or business problem in plain language.
- Separate facts, assumptions, constraints, and open questions.
- Identify who is affected and what outcome must improve.
- Define how success will be measured.
- Do not treat the first proposed solution as the problem statement.

## 2. Use first principles and make trade-offs explicit

- Break complex problems into smaller parts.
- Challenge assumptions that materially affect the design.
- Compare credible alternatives, including doing nothing.
- Explain the benefits, costs, risks, and conditions of each option.
- Record important decisions and why alternatives were not selected.

## 3. Prefer the simplest design that meets the real requirements

- Avoid abstractions, services, frameworks, and process without a clear benefit.
- Prefer clear ownership and cohesive domain boundaries.
- Keep interfaces explicit and responsibilities understandable.
- Use shared components when the capability and ownership are genuinely shared.
- Do not centralise unrelated domain behaviour merely to create one entry point.

## 4. Use deterministic software where it is the better tool

- Prefer code, rules, schemas, indexes, caches, and queries for deterministic work.
- Use an LLM when language understanding, synthesis, or uncertainty justifies it.
- Make model boundaries, tool permissions, and failure behaviour explicit.
- Do not use an agent to compensate for missing contracts or unreliable data without addressing the underlying issue.

## 5. Design for production, not only the happy path

Consider the quality attributes relevant to the system:

- Correctness and data quality
- Latency and throughput
- Availability and resilience
- Security and privacy
- Scalability and capacity
- Observability and operability
- Maintainability and changeability
- Cost and resource use

Define measurable targets where the risk or business impact warrants them. Do not invent targets when evidence is unavailable.

## 6. Make failure and recovery part of the design

- Identify dependency failures, timeouts, partial results, invalid inputs, and stale data.
- Define retries, idempotency, fallbacks, cancellation, and recovery where applicable.
- Make failure states visible to users and operators.
- Avoid silent data loss and success responses that hide incomplete work.

## 7. Deliver in small, verifiable increments

- Break work into reviewable changes.
- Define acceptance criteria before implementation.
- Test behaviour at the appropriate level.
- Run relevant checks and inspect the resulting diff.
- Report what changed, what was tested, and what remains uncertain.

## 8. Make decisions traceable

For consequential decisions, record:

- Context and problem
- Constraints and assumptions
- Options considered
- Decision and rationale
- Consequences, risks, and revisit conditions

Use an Architecture Decision Record (ADR) when a decision affects system boundaries, interfaces, data, reliability, security, or long-term operating cost.

## 9. Treat AI quality as an engineering concern

For AI-enabled systems:

- Evaluate task success, not only model output quality.
- Measure retrieval, grounding, tool selection, planning, execution, and recovery where relevant.
- Maintain representative evaluation cases, including negative and ambiguous inputs.
- Track latency and cost alongside quality.
- Separate deterministic failures from model uncertainty.
- Do not claim a system is accurate or production-ready without evidence.

## 10. Communicate for the decision and the audience

- Put the conclusion or requested decision first.
- Explain technical terms when the audience may not know them.
- Distinguish measured results from estimates and opinions.
- State risks, owners, and next actions clearly.
- Preserve technical accuracy when simplifying language.

## Decision checklist

Before committing to a meaningful design or implementation, ask:

1. Is the problem clear?
2. Which facts and assumptions support this approach?
3. What alternatives did we consider?
4. Is the design simpler than the alternatives without hiding complexity?
5. Are ownership and interfaces clear?
6. Have failure modes and operational needs been considered?
7. How will we test and measure success?
8. Can another engineer understand and maintain this?
