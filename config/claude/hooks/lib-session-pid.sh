#!/usr/bin/env bash
# Resolve the PID of the claude session that spawned the current hook by walking
# up the process tree. Printed on success; non-zero exit if no claude ancestor is
# found (so callers can fail safe rather than act on a wrong PID).
claude_session_pid() {
  local pid="$PPID" comm
  while [[ -n "$pid" && "$pid" -gt 1 ]]; do
    comm="$(ps -o comm= -p "$pid" 2>/dev/null)" || break
    case "$comm" in
      *claude) printf '%s' "$pid"; return 0 ;;
    esac
    pid="$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')"
  done
  return 1
}
