---
title: "LLM Tool Loops Are Slow - Here's What to Actually Do"
url: https://gist.github.com/garyblankenship/82d418fd0b6d93c9e809c14c95ee63d2
author: garyblankenship
platform: GitHub Gist
published: 2025-08-09
date_saved: 2026-09-21
tags: [function-calling, tool-use, latency, agents, cost-optimization]
---

## Why saved
Performance/cost angle on tool calling rather than correctness — complements
[[llm-tool-calling-token-level-deep-dive]] and [[openai-function-calling-340-tools-production]],
which focus on selection accuracy at scale, not latency/cost per call.

## Key points
- Core claim: the standard "loop back to the LLM after every tool call"
  pattern is an anti-pattern in production — each round-trip costs 200-500ms
  + full conversation history in tokens, and blocks sequentially.
- **Single-shot execution planning**: have the LLM output a complete plan
  (all tool calls + dependencies) as one JSON response, then execute the
  whole plan locally — one LLM call instead of N.
- **Tool chain compilation**: detect and hardcode common repeated call
  sequences (e.g. get_user → get_preferences → get_orders) so they skip the
  LLM entirely; only novel requests hit the LLM.
- **Context compression**: never resend full conversation history — send a
  task summary + compressed last-result + list of completed tool names only.
- **Tool batching**: design tools to accept arrays of operations
  (`get_weather_batch(requests=[...])`) instead of one call per item.
- Reports (informal, from the author's own production use — not an
  independent benchmark) 2,847ms/4,832 tokens for a naive 5-call sequential
  loop vs. 312ms/234 tokens for the planned+parallel approach.
- Core reframe: LLM tool calling is being used as an interpreter (return to
  LLM after every step) when it should be used as a compiler (LLM emits a
  full plan once, runtime executes it).

## Related
- [[llm-tool-calling-token-level-deep-dive]]
- [[openai-function-calling-340-tools-production]]

## To do
- [ ] Treat the specific ms/token numbers as one author's anecdotal
      before/after, not a verified benchmark, if citing this externally.
