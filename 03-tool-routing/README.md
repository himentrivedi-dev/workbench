# 03 — Tool Routing

## Purpose

Reduce tool-selection latency, prompt size and incorrect function calls as the catalog grows.

## Patterns

- Capability registry: tool/domain, inputs, dependencies, cost, freshness and constraints.
- Dynamic discovery: expose only relevant tools instead of all tools on every request.
- Tool gateway: centralize authentication, policy, routing, retries and observability.
- Embedding / lightweight routing: shortlist candidate domains before invoking an LLM.
- Better tool descriptions: optimize schemas and descriptions for selection accuracy.
- Big-tool routing: retrieve a small candidate set before detailed function calling.

## 43-tool problem

A large flat tool list creates context pressure and selection ambiguity. The target architecture should progressively narrow:

`query → domain candidates → capability candidates → executable tools → DAG`

This is complementary to MCP; MCP standardizes tool/resource interaction, while the application still needs routing, dependency semantics and execution policy.
