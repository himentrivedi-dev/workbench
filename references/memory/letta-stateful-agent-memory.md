---
title: "Letta — Stateful Agents and Persistent Memory"
url: https://github.com/letta-ai/letta
platform: GitHub
date_saved: 2026-10-23
tags: [memory, stateful-agents, context, travel-planning]
decision: EXPERIMENT
---

## Why saved

A reference for separating durable agent state from the limited context window of a single model invocation.

## Core idea

Letta provides infrastructure for stateful agents and memory management. Agents can retain and update selected information over time instead of depending entirely on a growing conversation transcript.

## Travel application

Keep a compact, explicit trip state such as:
- destination and travel dates
- travelers and confirmed constraints
- budget and preferences
- selected or rejected hotels/activities and reasons
- completed workflow nodes
- unresolved decisions and dependencies

Keep full search responses, supplier payloads, and inventory snapshots in an artifact store or source-of-truth system. Store references and concise summaries in agent memory, not every raw API response. Let the FastAPI orchestration layer own authorization, DAG dependencies, booking validation, and execution.

## What it does not replace

- A dependency-aware planner or DAG scheduler
- The authoritative hotel/activity inventory
- Fresh price and availability validation
- Transactional booking, cancellation, or modification logic

## Risks and evaluation

Test memory updates after user corrections, conflicting preferences, trip changes, and long conversations. Measure factual recall, stale-memory errors, constraint retention, token usage, and task completion. Use explicit expiration/versioning for facts that can change.

## Decision

**EXPERIMENT** — prototype persistent trip state while keeping execution and transactional truth outside the memory layer.

## Original sources

- Repository: https://github.com/letta-ai/letta
- Documentation: https://docs.letta.com/
- MemGPT and Letta overview: https://www.letta.com/blog/memgpt-and-letta/
