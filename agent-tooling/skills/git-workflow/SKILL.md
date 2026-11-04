---
name: git-workflow
description: Token-efficient Git operations for incremental commits, parallel agents, and safe integration into main. Use when creating worktrees, committing, integrating agent work, or recovering from Git uncertainty.
---

# Git workflow

Keep Git instructions small. The model decides scope, ownership, and conflict resolution; scripts perform repeatable Git operations.

## Defaults
- `main` is the permanent integration branch.
- Every task that changes Git history works on a task branch; parallel agents use separate worktrees named `agent/<task-slug>`.
- Only the orchestrator integrates branches into `main`.
- Commit coherent, reviewable units as soon as they pass relevant checks.
- Stage explicit paths only. Never use `git add .`, `git add -A`, or `git commit -a` by default.
- Preserve pre-existing/user changes. Never reset, clean, discard, stash, amend, rebase, force-push, or overwrite without explicit permission.

## Workflow
1. Inspect with `scripts/status.sh`; review status and diffs before editing.
2. Read `workflows.md` and follow the relevant section: incremental commit, parallel work, or integration.
3. Stage explicit paths and inspect the staged diff.
4. Run `scripts/commit.sh "type(scope): summary"` for each completed logical unit.
5. The orchestrator reviews and integrates one agent branch at a time with `scripts/integrate.sh <branch>`.

## Safety
- Never commit secrets, credentials, private keys, or unrelated changes.
- Run `git diff --cached --check` before committing.
- Do not commit directly to `main` or `master`.
- Never integrate a branch with uncommitted changes in its worktree.
- On conflicts, stop for deliberate resolution; never auto-select ours/theirs.
- No script pushes, rewrites history, deletes branches, or removes worktrees.
- If repository state or change ownership is unclear, stop and ask.

## Scripts
- `scripts/status.sh`: branch, status, upstream and worktree overview.
- `scripts/commit.sh`: checks and commits already-staged changes.
- `scripts/worktree.sh <slug> [base]`: creates `agent/<slug>` in a sibling worktree directory.
- `scripts/integrate.sh <branch>`: optional validation, then merge into the current `main` worktree.

Set `GIT_VALIDATE_CMD` to the project's real test command when integrating. If unset, integration warns that tests were not run. Never report unrun checks as passed.
