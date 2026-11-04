# Git workflows

## Incremental commits
1. Inspect `git status --short --branch`, `git diff`, and `git diff --cached`. Identify pre-existing changes; leave them untouched.
2. Group work into coherent units (implementation, tests, docs, etc.). Do not split changes that must work together.
3. Validate one unit, then stage explicit paths:
   ```bash
   git add path/to/file-a path/to/file-b
   git diff --cached --stat
   git diff --cached
   git diff --cached --check
   ```
4. Commit the staged unit:
   ```bash
   scripts/commit.sh "feat(search): add location-aware ranking"
   ```
5. Verify with `git show --stat --oneline HEAD`. Repeat for the next unit.
6. Report commit hashes, checks, and remaining changes.

If a file mixes task and unrelated edits, use `git add -p` or ask. Prefer a few meaningful commits over one commit per tiny edit. Never amend unless explicitly requested.

## Parallel agents
1. Orchestrator inspects repository state and splits work by independent file/path ownership.
2. Create one worktree per agent:
   ```bash
   scripts/worktree.sh ranking-tests main
   ```
3. Give each agent its worktree path, branch, owned paths, objective, acceptance criteria, and validation command.
4. Agents work only in their assigned worktree, commit logical units, and report branch, commit hashes, changed paths, checks, and unresolved issues.
5. Agents do not merge, rebase, push, modify another worktree, or delete worktrees.
6. Orchestrator integrates completed branches sequentially.

Avoid overlapping file ownership. If overlap is unavoidable, serialize the work. Worktrees isolate working directories, not semantic conflicts.

## Integrate into main
1. Run integration from the permanent `main` worktree. Confirm `git branch --show-current` is `main` and its worktree is clean.
2. Review the incoming commits and diff:
   ```bash
   git log --oneline main..agent/task
   git diff --stat main...agent/task
   git diff main...agent/task
   ```
3. Confirm the source worktree is clean.
4. Run the helper:
   ```bash
   GIT_VALIDATE_CMD='pytest -q' scripts/integrate.sh agent/task
   ```
   Use the project's actual checks. Without `GIT_VALIDATE_CMD`, the helper warns and proceeds without tests.
5. The helper creates a non-fast-forward merge commit. If a conflict occurs, stop and resolve it intentionally; do not auto-select conflict sides.
6. Inspect `git status --short --branch` and the merge commit. Keep the agent worktree and branch until the result is verified. Cleanup is a separate deliberate operation.

The integration helper never pushes to a remote.
