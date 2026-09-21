---
title: "Writing Good Descriptions (dynmcp guide)"
url: https://dynamicmcp.tools/guides/writing-descriptions/
author: brandonburrus (dynmcp project)
platform: dynamicmcp.tools docs
published: last updated 2026-05-25
date_saved: 2026-09-21
tags: [mcp, tool-selection, prompt-engineering, agents]
---

## Why saved
Short, concrete, practical companion to [[dynamic-discovery-mcp]] — a
reusable checklist for writing any tool/resource description an LLM has to
choose between, not just MCP-specific. Same principle as "descriptions are
the entire interface" from [[llm-tool-calling-token-level-deep-dive]].

## Key points
- A lazy-MCP `description` is read by the agent on every `discover_tool`
  call to decide whether to load that server — vague descriptions cause the
  agent to load the wrong thing, load nothing, or burn tokens guessing.
- Formula: **lead with verbs** (what can the agent *do* once loaded — not
  "browser automation tooling" but "navigate pages, take screenshots,
  inspect the DOM"), **name the domain** (the system/surface/data it
  operates on), **end with a "use when" clause** (disambiguates between
  several plausible-sounding options).
- Explicit anti-patterns to avoid: marketing copy ("the most powerful..."),
  enumerating individual tool names (that's what discovery is for),
  one-word descriptions ("Browser."), lead-ins like "An MCP that...", and
  omitting the "use when" clause entirely.
- Validation is enforced: an empty or whitespace-only description causes a
  startup error — no shipping a placeholder description.

## Related
- [[dynamic-discovery-mcp]] — the tool this guide's descriptions configure.
- [[llm-tool-calling-token-level-deep-dive]] — makes the same "description
  is the entire interface" point at the function-calling level, not just MCP.
