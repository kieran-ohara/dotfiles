#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -qE 'gh .* --repo'; then
  echo "BLOCKED: Do not use --repo flag with gh. You are already in the repo directory." >&2
  exit 2
fi

exit 0
