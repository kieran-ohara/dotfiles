#!/bin/bash
# Asks before a session works in a checkout another live session is already in.
# Runs on SessionStart (warn), PreToolUse:EnterWorktree and PreToolUse:Bash (ask).
INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')
SESSION=$(echo "$INPUT" | jq -r '.session_id // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

toplevel() {
  git -C "$1" rev-parse --show-toplevel 2>/dev/null
}

resolve() {
  case "$1" in
    /*) echo "$1" ;;
    "~"*) echo "${1/#\~/$HOME}" ;;
    *) echo "$CWD/$1" ;;
  esac
}

# Prints "name (status)" for each other live session whose checkout is $1.
occupants() {
  local target="$1"
  claude agents --json 2>/dev/null |
    jq -r --arg me "$SESSION" '.[] | select(.sessionId != $me) | select(.pid != null) | "\(.cwd)\t\(.name) (\(.status))"' |
    while IFS=$'\t' read -r cwd label; do
      if [ "$(toplevel "$cwd")" = "$target" ]; then
        echo "$label"
      fi
    done | paste -sd, - | sed 's/,/, /g'
}

ask() {
  jq -n --arg reason "$1" '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "ask", permissionDecisionReason: $reason}}'
  exit 0
}

case "$EVENT" in
  SessionStart)
    target=$(toplevel "$CWD")
    [ -z "$target" ] && exit 0
    who=$(occupants "$target")
    [ -z "$who" ] && exit 0
    msg="Another session is already working in $target: $who."
    jq -n --arg msg "$msg" '{systemMessage: $msg, hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: ($msg + " Before changing anything here, ask the user whether working alongside it is intended.")}}'
    exit 0
    ;;
  PreToolUse)
    TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')
    if [ "$TOOL" = "EnterWorktree" ]; then
      path=$(echo "$INPUT" | jq -r '.tool_input.path // empty')
      [ -z "$path" ] && exit 0
      target=$(toplevel "$(resolve "$path")")
      [ -z "$target" ] && exit 0
      who=$(occupants "$target")
      [ -n "$who" ] && ask "Already working in $target: $who. Enter it anyway?"
      exit 0
    fi

    [ "$TOOL" = "Bash" ] || exit 0
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
    targets=()

    # worktree remove acts on the named worktree; other destructive git acts on
    # this checkout, or the one named by -C.
    wt=$(echo "$COMMAND" | grep -oE 'worktree remove( --force| -f)* [^ ;&|]+' | awk '{print $NF}')
    if [ -n "$wt" ]; then
      targets+=("$(toplevel "$(resolve "$wt")")")
    elif echo "$COMMAND" | grep -qE '(^|[;&| /])git( -C [^ ]+)? (branch -[dD]|reset|rebase|checkout|switch|stash|clean|restore|push .*(-f|--force))'; then
      dir=$(echo "$COMMAND" | grep -oE 'git -C [^ ]+' | head -1 | awk '{print $3}')
      targets+=("$(toplevel "$(resolve "${dir:-.}")")")
    fi

    # Reaching into a different checkout with cd or git -C.
    for dir in $(echo "$COMMAND" | grep -oE '(cd|git -C) [^ ;&|]+' | awk '{print $NF}'); do
      t=$(toplevel "$(resolve "$dir")")
      [ -n "$t" ] && [ "$t" != "$(toplevel "$CWD")" ] && targets+=("$t")
    done

    for target in $(printf '%s\n' "${targets[@]}" | sort -u); do
      [ -z "$target" ] && continue
      who=$(occupants "$target")
      [ -n "$who" ] && ask "Already working in $target: $who. Run this there anyway?"
    done
    exit 0
    ;;
esac
exit 0
