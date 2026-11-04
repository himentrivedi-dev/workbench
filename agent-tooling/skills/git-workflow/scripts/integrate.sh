#!/usr/bin/env bash
set -euo pipefail
[[ $# -eq 1 && -n "$1" ]] || { echo "Usage: integrate.sh <agent-branch>" >&2; exit 2; }
branch="$1"
[[ "$branch" != "main" && "$branch" != "master" ]] || { echo "Source must be an agent branch." >&2; exit 2; }
git rev-parse --show-toplevel >/dev/null 2>&1 || { echo "Not inside a Git repository." >&2; exit 1; }
[[ "$(git branch --show-current)" == "main" ]] || { echo "Run integration from the main worktree." >&2; exit 1; }
[[ -z "$(git status --porcelain)" ]] || { echo "Main worktree is dirty; preserve and resolve changes first." >&2; git status --short; exit 1; }
git show-ref --verify --quiet "refs/heads/$branch" || { echo "Local branch not found: $branch" >&2; exit 1; }
git merge-base main "$branch" >/dev/null || { echo "Branches have no common ancestor." >&2; exit 1; }
[[ -n "$(git log --oneline "main..$branch")" ]] || { echo "No new commits to integrate." >&2; exit 1; }

agent_path=""
while IFS= read -r path; do
  [[ -n "$path" ]] || continue
  agent_path="$path"
  [[ -z "$(git -C "$path" status --porcelain)" ]] || { echo "Agent worktree is dirty: $path" >&2; git -C "$path" status --short; exit 1; }
done < <(git worktree list --porcelain | awk -v target="refs/heads/$branch" '
  /^worktree / { path=substr($0,10) }
  /^branch / && $2==target { print path }
')

echo "Incoming commits:"
git log --oneline "main..$branch"
echo
git diff --stat "main...$branch"

if [[ -n "${GIT_VALIDATE_CMD:-}" ]]; then
  [[ -n "$agent_path" ]] || { echo "Validation requested but branch has no registered worktree." >&2; exit 1; }
  echo "Running validation in $agent_path: $GIT_VALIDATE_CMD"
  (cd "$agent_path" && bash -lc "$GIT_VALIDATE_CMD")
else
  echo "WARNING: GIT_VALIDATE_CMD is unset; project tests were not run."
fi

git merge --no-ff --no-edit "$branch"
echo
git status --short --branch
git log -1 --oneline
echo "No remote push or worktree cleanup was performed."
