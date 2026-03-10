#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -q 'cd '; then
  if echo "$COMMAND" | grep -qE 'cd [^&|;]*&&.*(yarn|npm|npx|pnpm)'; then
    echo "BLOCKED: Do not use cd to run yarn/npm commands. Use yarn workspace or turbo instead." >&2
    exit 2
  fi
  echo "WARNING: You are using cd. Why? Consider using absolute paths or yarn workspace commands instead." >&2
fi

exit 0
