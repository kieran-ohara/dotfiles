#!/usr/bin/env bash
# Release this session's sleep block when its turn ends (Stop hook).
# Targets only the caffeinate keyed to this session's PID, so it can never
# affect another concurrent session's keepalive.
set -euo pipefail

source "$(dirname "$0")/lib-session-pid.sh"

session="$(claude_session_pid)" || exit 0

pkill -fx "caffeinate -dimsu -w $session" 2>/dev/null || true
