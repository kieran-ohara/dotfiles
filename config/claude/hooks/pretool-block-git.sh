#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -q 'git -C'; then
  echo "BLOCKED: Do not use git -C. Use cd to the repo root first, or use absolute paths." >&2
  exit 2
fi

if echo "$COMMAND" | grep -qE 'git add (\.|(-A|--all))'; then
  echo "BLOCKED: Do not use 'git add .' or 'git add -A'. Always explicitly list the specific files to stage." >&2
  exit 2
fi

exit 0
