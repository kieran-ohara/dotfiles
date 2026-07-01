#!/usr/bin/env bash
# Keep the Mac awake only while Claude Code is actively working.
# Started on UserPromptSubmit; the matching allow-sleep.sh stops it on Stop.
set -euo pipefail

PIDFILE="${TMPDIR:-/tmp}/claude-caffeinate.pid"

if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  exit 0
fi

caffeinate -dimsu &
echo $! > "$PIDFILE"
