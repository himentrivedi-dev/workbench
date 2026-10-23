---
title: "Anthropic — Effective Context Engineering for AI Agents"
url: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
platform: Anthropic Engineering
date_saved: 2026-10-23
tags: [context, agents, retrieval, prompt-engineering]
decision: ADOPT
---

## Why saved

A foundational reference for deciding what information should be placed in an agent's context, when to retrieve it, and how to avoid overwhelming the model with irrelevant material.

## Core idea

Context engineering is broader than prompt wording. It includes selecting, structuring, retrieving, and maintaining the information available to the model at each step of execution.

## Travel application

Use just-in-time context assembly:
1. Resolve the likely domain and user intent.
2. Retrieve the relevant capability descriptions and dependency rules.
3. Execute deterministic filters against current travel data.
4. Pass only the evidence needed for the current decision.
5. Preserve larger results as artifacts and retrieve subsets as needed.
6. Validate final constraints against authoritative data.

Keep stable instructions and tool contracts separate from per-request facts. Avoid repeatedly including all 43 tool descriptions and large hotel/activity payloads in every planner call.

## Risks and limitations

Context reduction must not remove facts needed for safety, constraint satisfaction, or transactional correctness. Use explicit schemas and validation rather than relying on a summary for exact price, dates, inventory, or booking state.

## Decision

**ADOPT** the principles of selective context assembly and retrieval-first execution; benchmark specific compression implementations separately.

## Original source

- Article: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
