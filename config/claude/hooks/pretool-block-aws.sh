#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -qE '^aws-vault exec .* -- aws( |$)'; then
  echo "BLOCKED: Do not use aws-vault for standard AWS CLI commands. Use: AWS_PROFILE=<profile> aws ..." >&2
  exit 2
fi

if echo "$COMMAND" | grep -qE '^aws( |$)'; then
  echo "BLOCKED: Do not invoke aws directly. Use: AWS_PROFILE=<profile> aws ..." >&2
  exit 2
fi

exit 0
