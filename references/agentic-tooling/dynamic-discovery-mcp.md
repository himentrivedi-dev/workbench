---
title: "dynmcp (dynamic-discovery-mcp) — Context management for MCP with dynamic tool discovery"
url: https://github.com/brandonburrus/dynamic-discovery-mcp
author: brandonburrus
platform: GitHub
published: unknown (23 commits, 17 open PRs at time of saving)
date_saved: 2026-09-21
tags: [mcp, tool-use, tool-selection, context-management, agents]
---

## Why saved
A proxy-layer solution to the "too many tools" problem, specific to MCP
rather than generic function-calling — collapses N upstream MCP tool
schemas down to 2 meta-tools the agent sees. Also has a companion guide
([[dynmcp-writing-descriptions]]) on writing descriptions for lazy-loaded
tools, directly relevant to any config-driven tool/dataset routing.

## Key points
- Wraps one or more upstream MCP servers and exposes only two meta-tools to
  the agent: `discover_tool` and `use_tool`. Full schemas of irrelevant
  tools never enter the model's context at all.
- **Lazy MCP loading**: an entire MCP server can be marked with a
  `description` in config and stays disconnected at startup; the agent only
  sees a short summary, and the connection opens on demand only when the
  agent calls `load_mcp`. Useful for expensive/rarely-needed MCPs (e.g.
  browser automation).
- Supports `stdio`, `streamable-http`, and `sse` transports for upstream
  MCPs in one config file (JSON or YAML), with shell-style `${VAR}` env
  interpolation.
- Full-fidelity proxying — resources, prompts, logging, cancellation,
  sampling/elicitation all pass through unchanged, not just tool calls.
- Local-only, single Node.js process over stdio — no daemon or remote
  endpoint to run.

## Related
- [[dynmcp-writing-descriptions]] — the companion guide on writing the
  `description` field that drives this lazy-discovery mechanism.
- [[ferrata-tool-gateway]] and [[langsmart-bigtool]] — same underlying
  problem (too many tool schemas in context) solved at the function-calling
  layer rather than the MCP-proxy layer.

## To do
- [ ] Consider whether this pattern (2 meta-tools + lazy discovery) applies
      to any future MCP-based tooling for
      [[batch-inference-enrichment-framework]], if it ever exposes its
      config/control-table operations as MCP tools.
