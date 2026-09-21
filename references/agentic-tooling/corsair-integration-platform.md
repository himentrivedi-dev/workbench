---
title: "Corsair — Connect your users to their apps"
url: https://github.com/corsairdev/corsair
author: corsairdev
platform: GitHub
published: unknown (1,614 commits, 11.3k stars at time of saving — mature/active project)
date_saved: 2026-09-21
tags: [mcp, integrations, oauth, agents, function-calling]
---

## Why saved
Adjacent to the tool-selection problem but a different layer — this is
about *connecting* agents/backends/dashboards to many third-party APIs
under one syntax, rather than helping an LLM choose among tools it already
has. Relevant if the enrichment framework or any future agent work needs
managed OAuth/third-party integrations rather than hand-rolled API clients.

## Key points
- Open-source integration/connector platform: one consistent syntax across
  many third-party APIs, maintained centrally as adapters rather than each
  team writing its own glue code per integration.
- Works over a REST API, not just MCP — so the same integration layer can
  back an agent, a backend service, or an end-user-facing dashboard, unlike
  MCP-only integration tools.
- Self-hostable (keeps user tokens/data on your own infra) or usable via a
  hosted "Hub" if you want OAuth refresh and webhook handling managed for
  you — data ownership stays with the self-hoster either way per the
  README's framing.
- Large, active OSS project (11.3k stars, 655 forks, 254 open issues at
  time of saving) with a public "OSS Integrations" claim process for
  contributing new adapters.
- Apache 2.0 licensed.

## Related
- [[dynamic-discovery-mcp]] — also about managing many tool/integration
  surfaces, but at the MCP-proxy/context-management layer rather than the
  OAuth/API-adapter layer Corsair operates at.

## To do
- [ ] Revisit if any future project needs multi-tenant third-party
      integrations (not directly relevant to
      [[batch-inference-enrichment-framework]], which only talks to
      internal AWS services).
