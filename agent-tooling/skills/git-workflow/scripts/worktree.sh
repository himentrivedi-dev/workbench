#!/usr/bin/env bash
set -euo pipefail
[[ $# -ge 1 && $# -le 2 ]] || { echo "Usage: worktree.sh <task-slug> [base-ref]" >&2; exit 2; }
slug="$1"
base="${2:-main}"
[[ "$slug" =~ ^[a-zA-Z0-9][a-zA-Z0-9._-]*$ ]] || { echo "Invalid task slug." >&2; exit 2; }
root="$(git rev-parse --show-toplevel 2>/dev/null)" || { echo "Not inside a Git repository." >&2; exit 1; }
repo_name="$(basename "$root")"
parent="$(dirname "$root")/${repo_name}-worktrees"
target="$parent/$slug"
branch="agent/$slug"
git show-ref --verify --quiet "refs/heads/$branch" && { echo "Branch already exists: $branch" >&2; exit 1; }
[[ ! -e "$target" ]] || { echo "Worktree path already exists: $target" >&2; exit 1; }
git rev-parse --verify "$base^{commit}" >/dev/null 2>&1 || { echo "Unknown base ref: $base" >&2; exit 1; }
mkdir -p "$parent"
git worktree add -b "$branch" "$target" "$base"
printf '\nBranch: %s\nWorktree: %s\n' "$branch" "$target"
