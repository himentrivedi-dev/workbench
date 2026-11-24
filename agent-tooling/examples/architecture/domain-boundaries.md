# Worked Example: Domain Boundaries in a Travel AI Platform

**Status:** Decision exercise, not a universal architecture recommendation.

## Problem

A travel platform supports Flights, Hotels, and Activities. A proposal suggests putting all domain behaviour into one central service.

## Options

| Option | Strengths | Risks / costs |
|---|---|---|
| Central service owns all domain logic | One deployment surface; shared orchestration can be straightforward | Domain coupling, broad release impact, central bottleneck, unclear ownership |
| Domain services own capabilities; framework orchestrates | Domain autonomy, clearer contracts, independent scaling and release | Requires contract discipline and cross-domain orchestration |
| Hybrid | Shared platform capabilities with domain-owned business rules | Boundary must be explicit; shared layer can expand into a monolith |

## Decision questions

- Which capabilities are genuinely shared?
- Which rules change independently by domain?
- Who owns data quality, APIs, incidents, and releases?
- Does a single-domain request need a multi-domain planner?
- What is the latency and failure-isolation impact?
- Can each domain be tested and deployed independently?

## Evaluation method

1. Map business capabilities and data ownership.
2. Trace single-domain and multi-domain journeys.
3. Measure call count, p95 latency, failure rate, and change coupling.
4. Compare operational ownership and team dependencies.
5. Record assumptions and revisit triggers in an ADR.

## Example decision statement

"Keep domain-specific search, pricing, availability, and booking rules within domain-owned services. Use a shared framework for cross-domain intent handling and orchestration where it provides measurable value. Route simple single-domain requests directly when dependencies do not require planning."

This is a hypothesis to validate against the actual system, not a default answer.
