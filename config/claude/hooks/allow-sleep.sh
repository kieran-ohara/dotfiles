#!/usr/bin/env bash
# Release the sleep block started by prevent-sleep.sh when Claude Code stops.
set -euo pipefail

PIDFILE="${TMPDIR:-/tmp}/claude-caffeinate.pid"

if [[ -f "$PIDFILE" ]]; then
  kill "$(cat "$PIDFILE")" 2>/dev/null || true
  rm -f "$PIDFILE"
fi
