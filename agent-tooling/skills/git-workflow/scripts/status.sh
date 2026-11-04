#!/usr/bin/env bash
set -euo pipefail
git rev-parse --show-toplevel >/dev/null 2>&1 || { echo "Not inside a Git repository." >&2; exit 1; }
printf 'Repository: %s\nBranch: %s\n' "$(git rev-parse --show-toplevel)" "$(git branch --show-current)"
git status --short --branch
printf '\nWorktrees:\n'
git worktree list
if git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' >/dev/null 2>&1; then
  printf '\nAhead/behind (local/remote): '
  git rev-list --left-right --count HEAD...@{upstream}
else
  printf '\nNo upstream configured.\n'
fi
