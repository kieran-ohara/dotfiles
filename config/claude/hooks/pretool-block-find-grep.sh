#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -qE '(^|\|)\s*find '; then
  echo "BLOCKED: Do not use find via Bash. Use the Glob tool instead." >&2
  exit 2
fi

if echo "$COMMAND" | grep -qE '(^|\|)\s*ls '; then
  echo "BLOCKED: Do not use ls via Bash. Use the Glob tool or Read tool instead." >&2
  exit 2
fi

if echo "$COMMAND" | grep -qE '^\s*(grep|rg) '; then
  echo "BLOCKED: Do not use grep/rg via Bash. Use the Grep tool instead." >&2
  exit 2
fi

exit 0
