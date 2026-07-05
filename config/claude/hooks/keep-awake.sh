#!/usr/bin/env bash
# Keep the Mac fully awake for the lifetime of THIS Claude session only.
#
# caffeinate is pinned to the session process with `-w`, so the kernel reaps it
# automatically when the session exits. No pidfile, no Stop hook, no shared
# state — each session's keep-awake lives and dies with exactly its own session,
# which makes it safe to run many sessions concurrently.
set -euo pipefail

# Walk up the process tree from this hook to find the owning `claude` process.
pid="$PPID"
session=""
while [[ -n "$pid" && "$pid" -gt 1 ]]; do
  case "$(ps -o comm= -p "$pid" 2>/dev/null)" in
    *claude) session="$pid"; break ;;
  esac
  pid="$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')"
done

# Fail safe: if we can't identify the session, do nothing rather than pin
# caffeinate to launchd (pid 1) and never release it.
[[ -n "$session" ]] || exit 0

# SessionStart can fire more than once per session (resume/clear); don't stack.
pgrep -fx "caffeinate -dimsu -w $session" >/dev/null 2>&1 && exit 0

caffeinate -dimsu -w "$session" </dev/null >/dev/null 2>&1 &
disown
