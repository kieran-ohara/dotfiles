#!/bin/bash
# Prints the model in use, the branch, and the worktree: "main" for the main
# working tree, otherwise its directory relative to the main working tree.
input=$(cat)
model=$(jq -r '.model.display_name // empty' <<<"$input")
dir=$(jq -r '.workspace.current_dir // empty' <<<"$input")

# The icons are drawn two cells wide but the terminal gives them one, so each
# is followed by two spaces to keep it off the text after it.
MODEL_ICON='󰙴'
BRANCH_ICON='󰘬'
WORKTREE_ICON='󰙅'
ORANGE=$'\033[38;5;208m'
GREEN=$'\033[32m'
BLUE=$'\033[34m'
RESET=$'\033[0m'

blue_if_main() {
  if [ "$2" = "main" ]; then
    printf '%s%s  %s%s' "$BLUE" "$1" "$2" "$RESET"
  else
    printf '%s  %s' "$1" "$2"
  fi
}

branch_name() {
  git branch --show-current 2>/dev/null | grep . || git rev-parse --short HEAD 2>/dev/null
}

worktree_name() {
  local git_dir common_dir
  git_dir=$(git rev-parse --path-format=absolute --git-dir 2>/dev/null) || return
  common_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || return
  if [ "$git_dir" = "$common_dir" ]; then
    printf 'main'
    return
  fi
  local main=${common_dir%/.git}
  local worktree
  worktree=$(git rev-parse --show-toplevel)
  printf '%s' "${worktree#"$main"/}"
}

segments=()

if [ -n "$model" ]; then
  case "$model" in
    *[Ff]able*) colour=$ORANGE ;;
    *[Oo]pus*) colour=$GREEN ;;
    *) colour='' ;;
  esac
  segments+=("${colour}${MODEL_ICON}  ${model}${colour:+$RESET}")
fi

if [ -n "$dir" ] && cd "$dir" 2>/dev/null; then
  branch=$(branch_name)
  [ -n "$branch" ] && segments+=("$(blue_if_main "$BRANCH_ICON" "$branch")")
  worktree=$(worktree_name)
  [ -n "$worktree" ] && segments+=("$(blue_if_main "$WORKTREE_ICON" "$worktree")")
fi

separator=''
for segment in "${segments[@]}"; do
  printf '%s%s' "$separator" "$segment"
  separator='  '
done
printf '\n'
