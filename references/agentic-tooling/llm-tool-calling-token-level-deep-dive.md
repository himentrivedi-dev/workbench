---
title: "LLM Tool Calling: Everything You Need in One Article (Part 1) — A Token-Level Deep Dive"
url: https://medium.com/@anshml/how-llm-tool-calling-actually-work-part-1-a-token-level-deep-dive-e8f700e0a0ca
author: Ansh Tanwar
platform: Medium
published: 2026-06-05
date_saved: 2026-09-21
tags: [function-calling, tool-use, llm-internals, agents, llm-production]
---

## Why saved
The clearest mechanical explanation found of *why* tool-calling bugs happen
(wrong tool picked, hallucinated tools, infinite tool loops) — grounds the
production pain points in [[openai-function-calling-340-tools-production]]
and the fixes in [[ferrata-tool-gateway]] in the actual token-level mechanics,
rather than treating them as folklore.

## Key points
- Tool definitions are not sent to a special "tools channel" — they are
  rendered as plain text into the prompt via the provider's chat template,
  then tokenized like everything else. A "tool call" is just sampled text
  that happens to match a trained structural pattern (e.g. `<tool_call>{...}</tool_call>`).
- Three properties of an LLM matter here: (1) everything in/out is tokens,
  no separate "tools" channel; (2) the only randomness is in final token
  sampling (temperature); (3) the model is stateless — every turn resends
  the entire context from scratch.
- **The "gap"** between the model emitting a tool-call string and your code
  actually running a function is where all production safety lives: registry
  lookup (existence), schema validation (validity), and an allow-list check
  you add yourself (permission). None of this is the model's doing.
- **The five classic production bugs, one root cause**: wrong tool among
  lookalikes, invented arguments, hallucinated tool names, one tool firing
  in an infinite loop, and prompt bloat from ever-growing "when X use Y"
  rules — all trace back to "a stateless next-token predictor wrapped in a
  loop, steered only by what's in its context."
- Constrained decoding (e.g. OpenAI's `strict: true`) fixes JSON *syntax*
  and can restrict the tool name to a registered set, but cannot fix a
  syntactically valid call to the *wrong* tool, or a fabricated-but-plausible
  argument value (e.g. an invented order ID) — those pass every gate.
- **No tool call is "terminal" by protocol** — if a tool is meant to end a
  turn, that has to be enforced in code (stop instruction in the tool's
  return value, cancel the loop's context, cap `MaxTurns`), not assumed from
  the tool's name/intent.
- Six concrete principles fall out of the mechanics: write discriminating
  descriptions (the description is the *entire* interface the model has),
  never trust model-supplied IDs for identity (resolve server-side instead),
  enforce termination in code with defense-in-depth, scope tools per persona
  rather than showing the model everything, lower temperature for
  routing/triage tasks, and log every call for later analysis.
- Sets up "Part 2" (not yet saved) which promises head-to-head experiments
  comparing flat tools vs. capability-scoped personas vs. hierarchical
  routing vs. retrieval-over-tools vs. multi-agent handoffs.

## Related
- [[openai-function-calling-340-tools-production]] — the production
  symptoms this article explains the mechanism behind.
- [[ferrata-tool-gateway]] — an implementation of several of this
  article's principles (tenant/persona tool scoping, schema validation,
  permission gates).
- [[tool-call-efficiency-patterns]] — a latency/cost-focused companion
  angle on the same tool-calling loop.

## To do
- [ ] Find and save Part 2 once published (comparative experiments on
      tool-selection strategies at scale).
