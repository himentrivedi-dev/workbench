#!/usr/bin/env bash
set -euo pipefail
[[ $# -eq 1 && -n "$1" ]] || { echo 'Usage: commit.sh "type(scope): summary"' >&2; exit 2; }
git rev-parse --show-toplevel >/dev/null 2>&1 || { echo "Not inside a Git repository." >&2; exit 1; }
branch="$(git branch --show-current)"
[[ -n "$branch" ]] || { echo "Detached HEAD; refusing to commit." >&2; exit 1; }
[[ "$branch" != "main" && "$branch" != "master" ]] || { echo "Direct commits to main/master are not allowed." >&2; exit 1; }
git rev-parse -q --verify MERGE_HEAD >/dev/null && { echo "Merge in progress; resolve it deliberately first." >&2; exit 1; }
git diff --cached --quiet && { echo "Nothing staged. Stage explicit paths and inspect the staged diff." >&2; exit 1; }

echo "Staged change summary:"
git diff --cached --stat
echo
git diff --cached --check
if git diff --cached --name-only | grep -E '(^|/)(\.env($|\.)|id_rsa|id_ed25519|.*\.(pem|key|p12|pfx))$' >/dev/null; then
  echo "Staged path resembles a secret/private key; inspect and unstage it." >&2
  exit 1
fi
echo "Staged diff:"
git diff --cached
git commit -m "$1"
git show --stat --oneline --summary HEAD
