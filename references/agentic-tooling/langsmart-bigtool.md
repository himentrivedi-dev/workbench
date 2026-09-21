---
title: "langsmart-bigtool — LangGraph agents with intelligent tool selection from large registries"
url: https://github.com/obinopaul/langsmart-bigtool
author: obinopaul
platform: GitHub
published: unknown (6 commits at time of saving)
date_saved: 2026-09-21
tags: [function-calling, tool-use, langgraph, agents, tool-selection]
---

## Why saved
A different tool-selection strategy than embedding/RAG-based retrieval —
uses a second LLM call instead. Useful comparison point against
[[sage-agentic-tooluse]] (which implements embedding/keyword/hybrid
selectors) and [[ferrata-tool-gateway]] (embedding-based semantic routing).

## Key points
- Two-node LangGraph architecture: a fast **selector LLM** (e.g.
  gpt-4o-mini) picks 3-10 relevant tools from a large registry based on the
  query and a text manifest of tool descriptions; a **main agent** (ReAct)
  then runs using only that selected subset.
- Explicitly positioned as a replacement for RAG/embedding-based tool
  retrieval — no vector store or embedding index to maintain. Claimed
  benefits: no embedding/vector-store management, better selection accuracy,
  faster cold start.
- Tool registry is just a dict of `{uuid: tool}` — framework-agnostic to add
  tools, scales to "500+ tools" per the README's example.
- Selection and execution LLMs can be different models/providers (e.g.
  gpt-4o-mini selector + claude-3-sonnet executor).
- Custom tool-selection logic can be substituted for the default LLM-driven
  selector (e.g. keyword-based shortcuts for known query patterns).

## Related
- [[sage-agentic-tooluse]] — same problem (tool selection at scale), solved
  via embedding/keyword/hybrid retrieval instead of a second LLM call.
- [[ferrata-tool-gateway]] — production-hardened gateway using embedding
  semantic routing, plus governance (auth, budget, audit) this repo doesn't
  cover.

## To do
- [ ] Compare actual selection accuracy/latency of this LLM-selector
      approach vs. embedding-based selection if evaluating for
      [[batch-inference-enrichment-framework]] config routing.
