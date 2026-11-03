"""Deterministic retrieval metrics for lodging search evaluation.

Input JSONL records should contain:
  {"qrels": [{"property_id": "p1", "relevance": 3}, ...],
   "results": [{"property_id": "p1", "score": 0.91}, ...]}

This module intentionally has no LLM dependency.
"""
from __future__ import annotations

import argparse
import json
import math
from pathlib import Path


def dcg(relevances: list[float], k: int) -> float:
    return sum(rel / math.log2(i + 2) for i, rel in enumerate(relevances[:k]))


def recall_at_k(qrels: dict[str, float], results: list[dict], k: int) -> float:
    relevant = {pid for pid, rel in qrels.items() if rel > 0}
    if not relevant:
        return 1.0
    found = {r["property_id"] for r in results[:k]} & relevant
    return len(found) / len(relevant)


def precision_at_k(qrels: dict[str, float], results: list[dict], k: int) -> float:
    if k <= 0:
        return 0.0
    relevant = {pid for pid, rel in qrels.items() if rel > 0}
    found = sum(1 for r in results[:k] if r["property_id"] in relevant)
    return found / min(k, len(results)) if results else 0.0


def mrr(qrels: dict[str, float], results: list[dict]) -> float:
    relevant = {pid for pid, rel in qrels.items() if rel > 0}
    for i, result in enumerate(results, 1):
        if result["property_id"] in relevant:
            return 1.0 / i
    return 0.0


def ndcg_at_k(qrels: dict[str, float], results: list[dict], k: int) -> float:
    observed = [qrels.get(r["property_id"], 0.0) for r in results[:k]]
    ideal = sorted(qrels.values(), reverse=True)
    ideal_dcg = dcg(ideal, k)
    return dcg(observed, k) / ideal_dcg if ideal_dcg else 1.0


def evaluate(records: list[dict], ks: list[int]) -> dict:
    output = {f"recall@{k}": [] for k in ks}
    output.update({f"precision@{k}": [] for k in ks})
    output.update({f"ndcg@{k}": [] for k in ks})
    output["mrr"] = []

    for record in records:
        qrels = {x["property_id"]: x["relevance"] for x in record["qrels"]}
        results = record["results"]
        for k in ks:
            output[f"recall@{k}"].append(recall_at_k(qrels, results, k))
            output[f"precision@{k}"].append(precision_at_k(qrels, results, k))
            output[f"ndcg@{k}"].append(ndcg_at_k(qrels, results, k))
        output["mrr"].append(mrr(qrels, results))

    return {metric: sum(values) / len(values) if values else 0.0 for metric, values in output.items()}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("dataset", type=Path)
    parser.add_argument("--k", nargs="+", type=int, default=[5, 10, 20])
    args = parser.parse_args()
    records = [json.loads(line) for line in args.dataset.read_text().splitlines() if line.strip()]
    print(json.dumps(evaluate(records, args.k), indent=2))


if __name__ == "__main__":
    main()
