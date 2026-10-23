# 11 — Travel Reference Architecture

## Current problem

A travel agent may have dozens of tools across Flight, Hotel and Activity journeys. Sending the full tool catalog to one Planner and planning every request creates avoidable latency, token cost and selection ambiguity.

## Target architecture

```text
User Query
   |
   v
Planner Gate / Domain Router
   |-------------------------------|
   | high-confidence               | complex / ambiguous / multi-domain
   v                               v
Direct Domain Agent          Existing Dynamic Planner
   |                               |
   |                               v
   |                        Capability + Dependency Registry
   |                               |
   |                               v
   |                         Runtime DAG Scheduler
   |                               |
   |                  +------------+------------+
   |                  |            |            |
   v                  v            v            v
Hotel Agent       Flight tools  Activity tools  Other tools
   |                  |            |            |
   +------------------+------------+------------+
                      |
                      v
              Validation / Merge
                      |
              State + Artifacts
                      |
                      v
                   Response
```

## Example: vacation planning

Query: "Plan a relaxing 5-day trip to Bali with a good hotel near the water and relaxing activities."

1. Gate detects Hotel + Activity intent → invoke the existing Planner.
2. Planner creates domain-level dependencies.
3. Hotel retrieval uses structured filters + semantic + geospatial retrieval.
4. Activity retrieval runs in parallel where independent.
5. Large result sets are filtered/aggregated before LLM synthesis.
6. Compact trip state stores constraints and selected entities.
7. Full API payloads remain artifacts/source data, not memory.
8. If the user later changes the hotel, only affected activity/route nodes are re-evaluated.

## Architecture decisions

| Decision | Recommendation | Reason |
|---|---|---|
| Planner Gate | Adopt | Avoid full planning for simple requests |
| Dynamic DAG | Keep | Handles genuine composition and dependencies |
| Capability registry | Adopt | Separates tool metadata from prompts |
| Parallel DAG execution | Adopt | Removes avoidable sequential latency |
| Artifact offloading | Experiment → Adopt if benchmarked | Reduces context pressure |
| Letta-style journey memory | Experiment | Useful for state, not inventory truth |
| Hybrid retrieval | Adopt | Travel has structured + semantic + geo needs |
| Runtime model selection | Experiment | Use cheap models for routing/simple tasks |
| Prompt/context caching | Adopt where stable | Reduces repeated token processing |

## Benchmark variants

A. Existing dynamic Planner only.

B. Planner Gate + existing Planner.

C. B + artifact storage + selective retrieval.

D. C + persistent trip-state memory.

E. D + safe caching + parallel DAG execution + runtime model selection + recovery.

The benchmark should compare p95 latency, success, constraint correctness, cost, token usage, tool calls and recovery—not latency alone.
