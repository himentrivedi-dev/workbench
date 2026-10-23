---
title: "Headroom — Context Compression and Caching"
url: https://github.com/headroomlabs-ai/headroom
platform: GitHub
date_saved: 2026-10-23
tags: [context, compression, caching, latency, agents]
decision: EXPERIMENT
---

## Why saved

A candidate for reducing prompt size and preserving useful context in agentic workflows, especially when tools return large JSON payloads.

## Core idea

Headroom focuses on context optimization, including structured-data compression, cache-aware context handling, and retrieval-oriented approaches. The aim is to reduce tokens and latency without forcing the model to process every raw tool result.

## Travel application

For hotel and activity planning, store full supplier/API responses in a durable artifact or data store. Use deterministic code to filter by dates, availability, location, budget, and required amenities; send only a compact, relevant representation to the model. Use compression only after preserving fields required for validation and booking.

## Risks and limits

- Compression can be lossy; never use a compressed representation as the source of truth for prices, availability, cancellation terms, or booking identifiers.
- Measure end-to-end quality, not token reduction alone.
- Preserve prompt-cache-friendly stable prefixes where possible.
- Validate that any compressed record still supports constraint checking and explanation.

## Evaluation plan

Compare baseline versus Headroom-enabled runs on token count, p95 latency, cost, constraint satisfaction, omitted-critical-field rate, and final-plan correctness. Include adversarial cases with similar hotels, conflicting amenities, and stale inventory.

## Decision

**EXPERIMENT** — trial it behind a feature flag with deterministic validation and a raw-data fallback.

## Original source

- Repository: https://github.com/headroomlabs-ai/headroom
