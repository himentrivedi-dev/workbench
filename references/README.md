# References

This folder is the **single source of truth for external research references** used by the workbench.

## Rule

Every research item added to this repository must include its source link. **No reference without a source link.**

Use the same record format in `index.md`:

| Date Saved | Title | Tags | Link |
|---|---|---|---|
| YYYY-MM-DD | Reference title | tag1, tag2 | [source](https://example.com) |

## Organization

- `index.md` — master reference catalog.
- `agentic-tooling/` — detailed notes for tool-calling, tool routing, MCP and tool gateways.
- `research-map.md` — categorized map of the research and how each reference maps to the travel architecture.

## Evidence rule

For each important reference, capture:

1. Problem solved
2. Core architecture/pattern
3. Source link
4. GitHub repository, when available
5. Measured results, when published
6. Production evidence vs prototype
7. Failure modes / limitations
8. Travel applicability
9. Decision: **ADOPT / EXPERIMENT / WATCH / REJECT**

The external source remains authoritative. Our notes are interpretation and architecture analysis, not a replacement for the source.
