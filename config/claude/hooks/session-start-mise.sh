#!/bin/bash
if command -v mise &>/dev/null && [ -n "$CLAUDE_ENV_FILE" ]; then
  mise env 2>/dev/null >> "$CLAUDE_ENV_FILE"
fi
exit 0
