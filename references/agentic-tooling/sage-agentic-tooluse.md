---
title: "sage-agentic-tooluse (SAGE Tool Use) — Tool retrieval and ranking algorithms for LLM agents"
url: https://github.com/RIDE-Lab/sage-agentic-tooluse
author: IntelliStream Team (RIDE-Lab / intellistream)
platform: GitHub / PyPI (isage-agentic-tooluse)
published: unknown (29 commits at time of saving; part of the larger SAGE ecosystem)
date_saved: 2026-09-21
tags: [tool-use, tool-selection, embeddings, agents, research]
---

## Why saved
A research-grade, algorithm-focused library specifically for tool
retrieval/ranking — a more academic counterpart to
[[langsmart-bigtool]] and [[ferrata-tool-gateway]]'s semantic router,
offering multiple named strategies to compare rather than one opinionated
approach.

## Key points
- Ships 5 distinct selector algorithms behind a common interface
  (`BaseToolSelector` + `SelectorRegistry`): Keyword (fast overlap
  matching), Embedding (semantic similarity), Hybrid (weighted combo of
  keyword + embedding), DFS-DT (decision-tree based), and Gorilla-style
  (API-centric retrieval, referencing the Gorilla LLM paper's approach).
- Pure Python library (`pip install isage-agentic-tooluse`), usable
  standalone or as part of the broader SAGE ("Stream Analytics for
  Generative AI Engines") ecosystem.
- Common query/result schema (`ToolSelectionQuery`, `ToolPrediction`) makes
  the different selectors directly swappable/comparable in the same
  pipeline — useful if benchmarking selection strategies against each other.
- References real academic tool-retrieval papers in its README (Toolshed,
  Graph RAG-Tool Fusion, a tool-retrieval benchmarking paper) — a
  reasonable starting point if wanting citations for a tool-selection
  literature review.

## Related
- [[langsmart-bigtool]] — same problem, LLM-driven two-stage selection
  instead of retrieval algorithms.
- [[ferrata-tool-gateway]] — production governance layer that includes one
  embedding-based selector as part of a larger pipeline (auth, validation,
  budget, audit), vs. this repo's focus purely on the selection algorithms
  themselves with several strategies to choose from.

## To do
- [ ] If ever benchmarking tool-selection approaches, this repo's 5
      algorithms + common schema could be the evaluation harness rather
      than building one from scratch.
