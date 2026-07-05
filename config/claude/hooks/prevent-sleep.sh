#!/usr/bin/env bash
# Keep the Mac awake while THIS claude session is actively working a turn.
# Started on UserPromptSubmit; released by allow-sleep.sh on Stop.
#
# caffeinate is keyed to the session by embedding the session PID in its own
# arguments (-w <pid>), so it is self-identifying — no shared pidfile, nothing
# to collide across concurrent sessions. The -w also makes the kernel reap it if
# the session dies before Stop fires, so a missed Stop can never leak.
set -euo pipefail

source "$(dirname "$0")/lib-session-pid.sh"

session="$(claude_session_pid)" || exit 0

# Already awake for this session's turn; don't stack another.
pgrep -fx "caffeinate -dimsu -w $session" >/dev/null 2>&1 && exit 0

caffeinate -dimsu -w "$session" </dev/null >/dev/null 2>&1 &
disown
