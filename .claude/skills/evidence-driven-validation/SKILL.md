---
name: evidence-driven-validation
description: Turn requirements into checkpoint-based validation, capture and annotate evidence, assess evidence quality and produce auditable summaries.
---
# Evidence-Driven Validation
A check is PASS only when executed and sufficient evidence supports the expected outcome. A screenshot alone is not proof of backend correctness.
Workflow: read requirements/scope → create stable checkpoint IDs → define preconditions/action/expected/evidence → execute in dependency order → preserve original artifacts → create linked annotated copies → assess evidence quality → summarize findings and readiness.
Statuses: PASS (executed and supported); FAIL (actual differs); BLOCKED (dependency/environment/access); SKIPPED (deliberately not run with reason); NOT RUN; N/A (reasoned not applicable). Never convert non-pass statuses to PASS.
Checkpoint fields: checkpoint_id, requirement, risk, preconditions, action, expected, actual, status, evidence_path, run_id, commit_sha, environment, executed_at_utc, notes.
Evidence quality: relevant, authentic original retained, legible, execution metadata recorded, sensitive data safely redacted in derivative, path exists, conclusion supported by artifact.
Annotation language: green=pass, red=fail, amber=warning, blue=info; numbered marker=checkpoint; rectangle=region; arrow=target; callout=explanation. One primary message per screenshot. Never obscure evidence. Preserve original and save annotated copy with suffix.
Release summary: counts by status, critical failures, blockers, skipped checks, evidence gaps, residual risks, recommendation READY / READY WITH ACCEPTED RISKS / NOT READY. Never infer readiness from pass percentage alone.
