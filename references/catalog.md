# Complete Reference Catalog

This file is the consolidated, link-first catalog of the external research used by this workbench. Every entry includes the original source URL.

## 1. Planning & Orchestration

### Anthropic — Building Effective Agents
- Problem: deciding when to use workflows versus autonomous agents.
- Pattern: routing, sequential/parallel workflows, orchestrator-worker patterns and evaluator loops.
- Travel fit: use deterministic workflow/DAG execution where dependencies are known; reserve agentic planning for ambiguous composition.
- Decision: **ADOPT**.
- Source: https://www.anthropic.com/research/building-effective-agents

### Anthropic — Multi-Agent Research System
- Problem: scaling complex research across independent subtasks.
- Pattern: lead agent, delegated workers, parallel execution and synthesis.
- Travel fit: useful for independent Hotel/Activity/Flight research; planner remains dependency authority.
- Decision: **EXPERIMENT**.
- Source: https://www.anthropic.com/engineering/multi-agent-research-system

### Ferrata
- Problem: infrastructure around LLM tool use and tool gateways.
- Pattern: gateway/infrastructure layer separated from application planning.
- Travel fit: reference for separating tool infrastructure from the dynamic Planner.
- Decision: **WATCH / EXPERIMENT**.
- Source: https://github.com/rajumb502/ferrata

## 2. Tool Routing & Tool Calling

### OpenAI Function Calling at 340 Tools
- Problem: large tool catalogs, multi-tenancy and production traffic make naive function calling difficult.
- Pattern: tool routing/discovery and production-aware architecture.
- Travel fit: directly relevant to the 43-tool catalog.
- Decision: **ADOPT architectural lesson; benchmark implementation**.
- Source: https://pub.towardsai.net/openai-function-calling-works-great-until-you-have-340-tools-12-tenants-real-production-traffic-fe02da116e39

### langsmart-bigtool
- Problem: selecting tools from a large catalog.
- Pattern: retrieve/narrow candidate tools before detailed function calling.
- Travel fit: query → domain → capability → executable tools.
- Decision: **EXPERIMENT**.
- Source: https://github.com/obinopaul/langsmart-bigtool

### Dynamic Discovery MCP
- Problem: exposing too many MCP tools to an agent.
- Pattern: dynamically discover/expose only relevant tools.
- Travel fit: reduces context and tool-selection ambiguity.
- Decision: **EXPERIMENT**.
- Source: https://github.com/brandonburrus/dynamic-discovery-mcp

### Dynamic MCP — Writing Good Descriptions
- Problem: poor tool descriptions reduce selection quality.
- Pattern: description engineering for dynamic tool discovery.
- Travel fit: improve Flight/Hotel/Activity schemas and tool descriptions.
- Decision: **ADOPT**.
- Source: https://dynamicmcp.tools/guides/writing-descriptions/

### SAGE Agentic Tool Use
- Problem: selecting useful tools efficiently.
- Pattern: tool-use selection algorithms and candidate selection.
- Travel fit: possible lightweight router before the main Planner.
- Decision: **EXPERIMENT**.
- Source: https://github.com/RIDE-Lab/sage-agentic-tooluse

### Corsair
- Problem: integrating external services/tools and authentication.
- Pattern: integration platform/tool infrastructure.
- Travel fit: reference for a centralized integration/tool layer.
- Decision: **WATCH / EXPERIMENT**.
- Source: https://github.com/corsairdev/corsair

### LLM Tool Calling — Token-Level Deep Dive
- Problem: understanding token/context overhead of tool calling.
- Pattern: token-level representation and generation of tool calls.
- Travel fit: useful for reasoning about schema and prompt overhead.
- Decision: **WATCH / EDUCATIONAL**.
- Source: https://medium.com/@anshml/how-llm-tool-calling-actually-work-part-1-a-token-level-deep-dive-e8f700e0a0ca

### Tool Call Efficiency Patterns
- Problem: redundant and inefficient tool calls.
- Pattern: reduce unnecessary calls and improve tool-call execution efficiency.
- Travel fit: directly applicable to planner latency and API cost.
- Decision: **EXPERIMENT**.
- Source: https://gist.github.com/garyblankenship/82d418fd0b6d93c9e809c14c95ee63d2

## 3. Context Engineering

### Headroom
- Problem: oversized agent context and repeated token processing.
- Pattern: compression, cache-aware context management and retrieval/compression.
- Travel fit: compress large hotel/activity outputs while keeping exact inventory outside model context.
- Decision: **EXPERIMENT**.
- Source: https://github.com/headroomlabs-ai/headroom

### Google ADK — Context Offloading with Artifacts
- Problem: large tool/API outputs consume model context.
- Pattern: store large outputs as artifacts and pass references/selected content.
- Travel fit: hotel/activity result sets and large API payloads.
- Decision: **EXPERIMENT → ADOPT if benchmarked**.
- Source: https://github.com/google/adk-python/tree/main/contributing/samples/patterns/context_offloading_with_artifact

### Anthropic — Effective Context Engineering
- Problem: agents fail when irrelevant or excessive information enters context.
- Pattern: deliberate context selection, retrieval and just-in-time information exposure.
- Travel fit: retrieval-first architecture and compact tool results.
- Decision: **ADOPT**.
- Source: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

### Anthropic — Code Execution with MCP
- Problem: putting large datasets directly into LLM context.
- Pattern: use code/tool execution to inspect and filter data before model synthesis.
- Travel fit: filter/aggregate hotel/activity datasets before exposing them to the LLM.
- Decision: **EXPERIMENT**.
- Source: https://www.anthropic.com/engineering/code-execution-with-mcp

## 4. Memory & Stateful Agents

### Letta
- Problem: maintaining persistent agent state and memory.
- Pattern: explicit memory blocks and stateful agents.
- Travel fit: compact trip state, user constraints, selected entities, completed DAG nodes and pending dependencies.
- Decision: **EXPERIMENT**.
- Source: https://github.com/letta-ai/letta
- Documentation: https://docs.letta.com/

### Letta Awesome
- Problem: finding examples and ecosystem patterns.
- Pattern: curated Letta implementations/resources.
- Travel fit: prototype ideas for persistent trip state.
- Decision: **WATCH**.
- Source: https://github.com/letta-ai/awesome-letta

### Letta Agent SDK
- Problem: embedding stateful agents into applications.
- Pattern: agent application SDK.
- Travel fit: prototype state/memory layer around the vacation planner.
- Decision: **EXPERIMENT**.
- Source: https://github.com/letta-ai/letta-agent-sdk

### Letta Code
- Problem: applying persistent agent state/memory to coding workflows.
- Pattern: Letta-based coding agent implementation.
- Travel fit: indirect reference for stateful-agent architecture.
- Decision: **WATCH**.
- Source: https://github.com/letta-ai/letta-code

### LongMemEval
- Problem: evaluating long-term memory retrieval and temporal updates.
- Pattern: memory evaluation across updated, temporal and conflicting information.
- Travel fit: evaluate changed trip preferences and decisions across turns.
- Decision: **ADOPT as evaluation inspiration**.
- Source: https://github.com/xiaowu0162/LongMemEval

## 5. Retrieval & Knowledge

### Search-R1
- Problem: improving retrieval through iterative search/reasoning.
- Pattern: agentic search/reasoning loop.
- Travel fit: useful for iterative discovery, but exact filters and live inventory stay deterministic.
- Decision: **EXPERIMENT**.
- Source: https://github.com/PeterGriffinJin/Search-R1

### Open Knowledge Format (OKF)
- Problem: making curated knowledge usable and portable for AI systems.
- Pattern: structured knowledge bundles and stable source material.
- Travel fit: tool contracts, business rules, schemas and policies; not live availability/price.
- Decision: **EXPERIMENT**.
- Source: https://github.com/GoogleCloudPlatform/open-knowledge-format

### OKF Specification
- Problem: defining the OKF structure precisely.
- Pattern: formal specification for knowledge bundles.
- Travel fit: useful when creating stable agent knowledge packages.
- Decision: **REFERENCE**.
- Source: https://github.com/GoogleCloudPlatform/open-knowledge-format/blob/main/SPEC.md

## 6. Caching

### Redis Semantic Cache
- Problem: repeated semantically similar requests cause repeated expensive work.
- Pattern: semantic caching with freshness-aware reuse.
- Travel fit: safe for stable/repeatable planning and retrieval operations; never blindly cache live price/availability.
- Decision: **EXPERIMENT**.
- Source: https://redis.io/docs/latest/develop/use-cases/semantic-cache/

## 7. Execution & Runtime

### Orloj
- Problem: operating multi-agent systems with explicit runtime policies.
- Pattern: declarative agents/tools/policies, retries and worker processes.
- Travel fit: reference for separating orchestration from runtime execution.
- Decision: **WATCH / EXPERIMENT**.
- Source: https://github.com/orlojHQ/orloj

### Agent Runtime Platform
- Problem: reliable long-running agent execution and recovery.
- Pattern: durable execution, policy-governed tools, recovery and DAG concepts.
- Travel fit: selective replay for booking/modification/cancellation workflows.
- Decision: **EXPERIMENT**.
- Source: https://github.com/YingzuoLiu/agent-runtime-platform

### XState
- Problem: representing explicit state transitions reliably.
- Pattern: state machines and lifecycle transitions.
- Travel fit: booking, modification and cancellation state management.
- Decision: **EXPERIMENT**.
- Source: https://github.com/statelyai/xstate

### Microsoft AutoGen
- Problem: coordinating multiple agents and workflows.
- Pattern: multi-agent orchestration and agent workflows.
- Travel fit: comparison/reference implementation for multi-agent execution.
- Decision: **WATCH / EXPERIMENT**.
- Source: https://github.com/microsoft/autogen

## 8. Evaluation & Observability

### BFCL — Berkeley Function Calling Leaderboard
- Problem: measuring function/tool selection and argument quality.
- Pattern: benchmark for tool calling, arguments, parallel/multi-turn calls.
- Travel fit: directly relevant to 43-tool selection quality.
- Decision: **ADOPT as benchmark inspiration**.
- Source: https://github.com/ShishirPatil/gorilla/tree/main/berkeley-function-call-leaderboard

### τ-bench
- Problem: evaluating multi-turn tool-use workflows and state changes.
- Pattern: simulated users/APIs and stateful workflows.
- Travel fit: close to booking/modification/cancellation reliability.
- Decision: **ADOPT as benchmark inspiration**.
- Source: https://github.com/sierra-research/tau-bench

### MLflow
- Problem: comparing GenAI experiments and tracing production behavior.
- Pattern: tracing, evaluation and experiment comparison.
- Travel fit: compare Planner variants using latency, tokens, tool calls, errors and success.
- Decision: **ADOPT if platform fit is good**.
- Source: https://github.com/mlflow/mlflow

## 9. Multi-Agent Reference Implementations

### Multi-Agent Orchestration
- Problem: building an end-to-end multi-agent service.
- Pattern: Supervisor routing, FastAPI, LangGraph, MCP, retrieval and persistent state.
- Travel fit: useful implementation reference for a FastAPI-based architecture.
- Decision: **WATCH / EXPERIMENT**.
- Source: https://github.com/Theepankumargandhi/Multi-Agent-Orchestration

### Pavel Valentov — Multi-Agent Architecture
- Problem: understanding architectural evolution of multi-agent systems.
- Pattern: concurrency, shared state, prompt-cache reuse and execution governance.
- Travel fit: useful architecture catalogue, not production proof.
- Decision: **WATCH**.
- Source: https://github.com/PavelValentov/multi-agent-architecture

## 10. Travel Implementations

### Vacation Planner Agent
- Problem: composing travel recommendations across multiple domains.
- Pattern: multi-agent travel planning across flights, hotels, attractions and weather.
- Travel fit: direct domain example; useful for comparing orchestration approaches.
- Decision: **EXPERIMENT / REFERENCE**.
- Source: https://github.com/asim-aa/vacation-planner-agent

### StarterMonk Travel Planner Agent
- Problem: implementing a stateful travel planner.
- Pattern: travel planning with LangGraph.
- Travel fit: comparison implementation for travel orchestration.
- Decision: **WATCH / REFERENCE**.
- Source: https://github.com/StarterMonk/Travel_Planner_Agent

## 11. Source-of-Truth Rule

External research is guidance, not authority. For the travel architecture:

- Price → live deterministic travel API/system.
- Availability → live deterministic travel API/system.
- Booking state → booking system.
- Tool dependencies → capability/dependency registry.
- Journey state → state store/memory layer.
- Large tool/API outputs → artifacts/data stores.
- Stable policies/contracts → curated knowledge/reference layer.

No memory, semantic cache, vector index, compressed context or curated knowledge file should become the authoritative source for live price, availability or booking state.
