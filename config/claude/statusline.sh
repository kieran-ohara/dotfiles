#!/bin/bash
# Prints the model in use and the worktree: "main" for the main working tree,
# otherwise its directory relative to the main working tree.
input=$(cat)
model=$(jq -r '.model.display_name // empty' <<<"$input")
dir=$(jq -r '.workspace.current_dir // empty' <<<"$input")

worktree_label() {
  [ -n "$dir" ] && cd "$dir" 2>/dev/null || return
  local git_dir common_dir
  git_dir=$(git rev-parse --path-format=absolute --git-dir 2>/dev/null) || return
  common_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || return
  if [ "$git_dir" = "$common_dir" ]; then
    printf 'worktree: main'
    return
  fi
  local main=${common_dir%/.git}
  local worktree
  worktree=$(git rev-parse --show-toplevel)
  printf 'worktree: %s' "${worktree#"$main"/}"
}

ORANGE=$'\033[38;5;208m'
GREEN=$'\033[32m'
RESET=$'\033[0m'
case "$model" in
  *[Ff]able*) model="${ORANGE}${model}${RESET}" ;;
  *[Oo]pus*) model="${GREEN}${model}${RESET}" ;;
esac

worktree=$(worktree_label)
printf '%s%s\n' "$model" "${worktree:+ · $worktree}"
