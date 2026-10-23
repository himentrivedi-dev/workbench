# Research Map

This is the categorized reference map behind the workbench. **Every item below has an external source link.**

## Planning

### Anthropic — Building Effective Agents
- Pattern: workflows vs agents, routing, parallelization, orchestration.
- Travel relevance: supports using deterministic workflows where possible and reserving agentic planning for genuinely open-ended tasks.
- Decision: ADOPT as architectural guidance.
- Source: https://www.anthropic.com/research/building-effective-agents

### Anthropic — Multi-Agent Research System
- Pattern: lead agent + delegated workers + parallel execution + synthesis.
- Travel relevance: useful for independent Hotel/Activity/Flight research, but the travel planner must retain dependency authority.
- Decision: EXPERIMENT.
- Source: https://www.anthropic.com/engineering/multi-agent-research-system

### Ferrata
- Pattern: tool gateway / infrastructure for LLM tool use.
- Travel relevance: useful reference for separating tool infrastructure from planner logic.
- Decision: WATCH / EXPERIMENT.
- Source: https://github.com/rajumb502/ferrata

## Tool Routing / 43-Tool Problem

### OpenAI Function Calling at 340 Tools
- Pattern: large tool catalogs create production routing/context problems.
- Travel relevance: directly relevant to a 43-tool catalog and multi-tenant traffic.
- Decision: ADOPT the architectural lesson; benchmark implementation choices.
- Source: https://pub.towardsai.net/openai-function-calling-works-great-until-you-have-340-tools-12-tenants-real-production-traffic-fe02da116e39

### langsmart-bigtool
- Pattern: narrow a large tool catalog before detailed tool calling.
- Travel relevance: query → candidate domains/tools → execution.
- Decision: EXPERIMENT.
- Source: https://github.com/obinopaul/langsmart-bigtool

### Dynamic Discovery MCP
- Pattern: dynamically expose relevant MCP tools rather than the full catalog.
- Travel relevance: reduces tool context and selection ambiguity.
- Decision: EXPERIMENT.
- Source: https://github.com/brandonburrus/dynamic-discovery-mcp

### Dynamic MCP — Writing Good Descriptions
- Pattern: improve tool descriptions for reliable selection.
- Travel relevance: important for flight/hotel/activity schemas.
- Decision: ADOPT as a tool-authoring practice.
- Source: https://dynamicmcp.tools/guides/writing-descriptions/

### SAGE Agentic Tool Use
- Pattern: research into tool-selection algorithms and candidate selection.
- Travel relevance: useful for the lightweight routing layer before the Planner.
- Decision: EXPERIMENT.
- Source: https://github.com/RIDE-Lab/sage-agentic-tooluse

### Corsair
- Pattern: integration/tool platform, OAuth and tool infrastructure.
- Travel relevance: reference for a centralized tool/integration layer.
- Decision: WATCH / EXPERIMENT.
- Source: https://github.com/corsairdev/corsair

### LLM Tool Calling — Token-Level Deep Dive
- Pattern: explains how tool calls are represented and generated at token level.
- Travel relevance: helps reason about schema/context/token overhead.
- Decision: WATCH / EDUCATIONAL.
- Source: https://medium.com/@anshml/how-llm-tool-calling-actually-work-part-1-a-token-level-deep-dive-e8f700e0a0ca

### Tool Call Efficiency Patterns
- Pattern: reduce redundant and inefficient tool calls.
- Travel relevance: directly applicable to planner latency and API cost.
- Decision: EXPERIMENT.
- Source: https://gist.github.com/garyblankenship/82d418fd0b6d93c9e809c14c95ee63d2

## Context Engineering

### Headroom
- Pattern: context compression, cache-aware context management and retrieval/compression techniques.
- Travel relevance: large hotel/activity results can be compressed, but exact inventory remains outside the compressed context.
- Decision: EXPERIMENT.
- Source: https://github.com/headroomlabs-ai/headroom

### Google ADK — Context Offloading with Artifacts
- Pattern: move large context into artifacts and reference it from the agent workflow.
- Travel relevance: strong candidate for hotel/activity result sets and large API responses.
- Decision: EXPERIMENT → ADOPT if benchmarked.
- Source: https://github.com/google/adk-python/tree/main/contributing/samples/patterns/context_offloading_with_artifact

### Anthropic — Effective Context Engineering
- Pattern: deliberately manage what information enters model context and when.
- Travel relevance: supports retrieval-first and just-in-time context.
- Decision: ADOPT as design principle.
- Source: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

### Anthropic — Code Execution with MCP
- Pattern: let agents operate on data through code/tools instead of placing all raw data in context.
- Travel relevance: filter/aggregate large hotel/activity datasets before model synthesis.
- Decision: EXPERIMENT.
- Source: https://www.anthropic.com/engineering/code-execution-with-mcp

## Memory / State

### Letta
- Pattern: stateful agents, memory blocks and explicit memory operations.
- Travel relevance: compact trip state, constraints, selected entities, completed DAG nodes and pending dependencies.
- Decision: EXPERIMENT.
- Source: https://github.com/letta-ai/letta
- Documentation: https://docs.letta.com/

### Letta Awesome
- Pattern: examples and ecosystem references.
- Travel relevance: implementation ideas for persistent agent state.
- Decision: WATCH.
- Source: https://github.com/letta-ai/awesome-letta

### Letta Agent SDK
- Pattern: agent application integration.
- Travel relevance: useful if a prototype uses Letta as the state layer.
- Decision: EXPERIMENT.
- Source: https://github.com/letta-ai/letta-agent-sdk

### LongMemEval
- Pattern: evaluate long-term memory retrieval, updates and temporal reasoning.
- Travel relevance: benchmark whether changed trip preferences and decisions are correctly remembered.
- Decision: ADOPT as evaluation inspiration.
- Source: https://github.com/xiaowu0162/LongMemEval

## Retrieval

### Search-R1
- Pattern: agentic search/reasoning loop for retrieval.
- Travel relevance: useful reference for iterative retrieval, but travel still needs deterministic filters and live inventory APIs.
- Decision: EXPERIMENT.
- Source: https://github.com/PeterGriffinJin/Search-R1

### Open Knowledge Format (OKF)
- Pattern: structured, curated knowledge format for stable knowledge.
- Travel relevance: good fit for tool contracts, business rules, schemas and policies; not live hotel price/availability.
- Decision: EXPERIMENT.
- Source: https://github.com/GoogleCloudPlatform/open-knowledge-format
- Specification: https://github.com/GoogleCloudPlatform/open-knowledge-format/blob/main/SPEC.md

## Caching

### Redis Semantic Cache
- Pattern: reuse results for semantically similar requests.
- Travel relevance: useful for safe, freshness-aware caching of stable or repeatable retrieval/planning operations.
- Decision: EXPERIMENT.
- Source: https://redis.io/docs/latest/develop/use-cases/semantic-cache/

## Execution / Runtime

### Orloj
- Pattern: declarative multi-agent runtime with agents, tools, policies, retries and worker processes.
- Travel relevance: reference for separating orchestration policy from runtime execution.
- Decision: WATCH / EXPERIMENT.
- Source: https://github.com/orlojHQ/orloj

### Agent Runtime Platform
- Pattern: durable execution, policy-governed tools, recovery and DAG-oriented runtime concepts.
- Travel relevance: selective replay and recovery are important for multi-step booking workflows.
- Decision: EXPERIMENT.
- Source: https://github.com/YingzuoLiu/agent-runtime-platform

### XState
- Pattern: explicit state machines and lifecycle transitions.
- Travel relevance: useful for booking/modification/cancellation state transitions and recovery.
- Decision: EXPERIMENT.
- Source: https://github.com/statelyai/xstate

### Microsoft AutoGen
- Pattern: multi-agent orchestration and agent workflows.
- Travel relevance: reference implementation for agent communication and workflow patterns.
- Decision: WATCH / EXPERIMENT.
- Source: https://github.com/microsoft/autogen

## Evaluation

### BFCL — Berkeley Function Calling Leaderboard
- Pattern: benchmark function calling, tool selection, arguments and multi-turn tool use.
- Travel relevance: directly useful for measuring 43-tool selection quality.
- Decision: ADOPT as external benchmark inspiration.
- Source: https://github.com/ShishirPatil/gorilla/tree/main/berkeley-function-call-leaderboard

### τ-bench
- Pattern: multi-turn tool-use workflows with simulated APIs and state changes.
- Travel relevance: close to booking/modification/cancellation reliability problems.
- Decision: ADOPT as benchmark inspiration.
- Source: https://github.com/sierra-research/tau-bench

### MLflow
- Pattern: tracing and GenAI evaluation.
- Travel relevance: compare planner variants using latency, tokens, tool calls, errors and task success.
- Decision: ADOPT for observability/evaluation if it fits the platform.
- Source: https://github.com/mlflow/mlflow

## Multi-Agent Implementations

### Multi-Agent Orchestration
- Pattern: supervisor routing, FastAPI, LangGraph, MCP, retrieval and persistent state.
- Travel relevance: useful end-to-end implementation reference.
- Decision: WATCH / EXPERIMENT.
- Source: https://github.com/Theepankumargandhi/Multi-Agent-Orchestration

### Pavel Valentov — Multi-Agent Architecture
- Pattern: architecture evolution, concurrency, shared state, prompt-cache reuse and execution governance.
- Travel relevance: useful architecture catalogue rather than a production guarantee.
- Decision: WATCH.
- Source: https://github.com/PavelValentov/multi-agent-architecture

## Travel Implementations

### Vacation Planner Agent
- Pattern: multi-agent travel planning across flights, hotels, attractions and weather.
- Travel relevance: directly useful as a domain example, while not being proof of production scale.
- Decision: EXPERIMENT / REFERENCE.
- Source: https://github.com/asim-aa/vacation-planner-agent

### StarterMonk Travel Planner Agent
- Pattern: travel planning with LangGraph.
- Travel relevance: useful comparison implementation for stateful travel orchestration.
- Decision: WATCH / REFERENCE.
- Source: https://github.com/StarterMonk/Travel_Planner_Agent

## Source-of-truth rule for travel

No memory, semantic cache, vector index, compressed context or curated knowledge file should become the authoritative source for **live price, availability or booking state**. Those remain with the appropriate deterministic travel systems/APIs.
