---
name: deployment-engineering
description: Design, review, operate and troubleshoot CI/CD and deployments, including Spinnaker, GitHub Actions, Jenkins and Argo CD.
---
# Deployment Engineering
Trace source commit → build → tests/scans → immutable artifact → promotion → deployment → verification. Identify platform, environments, ownership, approvals, credentials, gates and audit trail.
Controls: least-privilege identities; scoped secrets; required tests/scans; approvals where required; environment config separated from artifacts; concurrency controls; clear failure notifications and audit logs.
Choose rolling, blue/green, canary or recreate based on statefulness, traffic, rollback safety and infrastructure. Define health metrics and abort thresholds before rollout.
Rollback: explicit trigger/owner; check DB backward compatibility; use expand-and-contract migrations when needed; verify recovery; document when forward-fix is safer.
For Spinnaker inspect pipelines, stages, strategies, constraints and execution details. Adapt equivalent concepts to other platforms. Never claim a deployment occurred without execution evidence.
