---
title: "OpenAI Function Calling Works Great, Until You Have 340 Tools, 12 Tenants, and Real Production Traffic"
url: https://pub.towardsai.net/openai-function-calling-works-great-until-you-have-340-tools-12-tenants-real-production-traffic-fe02da116e39
author: Teja Kusireddy
platform: Towards AI
published: 2026 (verify original article for exact publication date)
date_saved: 2026-09-21
tags: [function-calling, multi-tenant, llm-production, tool-routing, latency]
---

## Why saved

A production-oriented reference for scaling tool calling beyond a small demo. It is especially relevant to the travel-agent architecture, which has 43 tools across multiple journeys and must keep planner latency and tool-selection errors under control.

## Problem addressed

Exposing a large, undifferentiated tool set to every model call increases selection complexity, prompt/context size, routing ambiguity, and the operational burden of tenant-specific behavior. A design that works with a handful of tools may degrade when the tool surface and traffic grow.

## Key architecture lessons

- Treat tool discovery and routing as an explicit system concern rather than repeatedly asking one model to reason over every available tool.
- Separate the public tool/integration surface from the runtime path that chooses and executes a specific capability.
- Scope capabilities to the relevant tenant, domain, and task before model invocation.
- Measure end-to-end reliability and latency under realistic tool counts and concurrent traffic; do not rely only on a demo or isolated model-call benchmark.
- Keep deterministic dependency and execution rules outside the language model where possible.

## Application to the travel planner

For the current 43-tool setup, use a progressive narrowing path:

`user request → domain candidates → capability candidates → eligible tools → dependency DAG → execution`

A lightweight Planner Gate should route high-confidence single-domain requests directly to the relevant domain agent. Invoke the existing dynamic DAG planner when a request is multi-domain, ambiguous, or requires composition. Keep dependency constraints—such as search results requiring a search ID—in a capability/dependency registry rather than relying on the model to rediscover them every turn.

## Evidence and limitations

- **Source type:** practitioner article / architecture case study.
- **Evidence to verify before adoption:** exact workload, measured latency and reliability improvements, tenant-isolation mechanisms, and whether reported numbers are independently reproducible.
- Do not treat a published architecture narrative as proof that the same design will improve this travel workload without a controlled benchmark.
- Benchmark against the existing planner using p50/p95/p99 latency, successful constraint-correct completion rate, tool-selection accuracy, tool calls, token usage, cost, and false single-domain bypass rate.

## Decision

**EXPERIMENT** — use the article to shape the tool-routing and Planner Gate benchmark. Adopt only the parts that demonstrate measurable improvements on the travel workload.

## Related references

- [Ferrata — LLM Tool Gateway](https://github.com/rajumb502/ferrata)
- [Corsair — Integration Platform](https://github.com/corsairdev/corsair)
- [Berkeley Function Calling Leaderboard (BFCL)](https://github.com/ShishirPatil/gorilla/tree/main/berkeley-function-call-leaderboard)

## Original source

- Article: https://pub.towardsai.net/openai-function-calling-works-great-until-you-have-340-tools-12-tenants-real-production-traffic-fe02da116e39
