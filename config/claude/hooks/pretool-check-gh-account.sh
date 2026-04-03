#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if ! echo "$COMMAND" | grep -q '^gh '; then
  exit 0
fi

if echo "$COMMAND" | grep -q '^gh auth switch'; then
  exit 0
fi

if [ -z "$GH_REQUIRED_ACCOUNT" ]; then
  exit 0
fi

ACTIVE_USER=$(gh auth status --active --json hosts --jq '.hosts."github.com".[0].login' 2>/dev/null)

if [ "$ACTIVE_USER" != "$GH_REQUIRED_ACCOUNT" ]; then
  echo "BLOCKED: Wrong GitHub account active (got '$ACTIVE_USER', need '$GH_REQUIRED_ACCOUNT'). Run: gh auth switch --user $GH_REQUIRED_ACCOUNT" >&2
  exit 2
fi

exit 0
