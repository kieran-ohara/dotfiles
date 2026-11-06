#!/bin/sh
# Usage: survey.sh <repo-root> [path-filter]
#
# Fetches every git submodule under the repo whose path matches the filter
# (default: site/pack) and prints one tab-separated row per submodule:
#
#   behind  path  current-sha  upstream-sha  current-tag  upstream-tag  changelog
#
# "behind" is the number of upstream commits not in the checked-out commit.
# Tags are the nearest reachable tag, or "-" when the repo has none.
# "changelog" is the changelog file name at upstream, or "-".
set -e
root=$1
filter=${2:-site/pack}
cd "$root"

inspect() {
  path=$1
  cd "$root/$path" || return 0
  git fetch -q origin 2>/dev/null || true
  up=$(git rev-parse --abbrev-ref origin/HEAD 2>/dev/null || echo origin/master)
  cur=$(git rev-parse HEAD)
  upsha=$(git rev-parse "$up" 2>/dev/null || echo "?")
  behind=$(git rev-list --count "HEAD..$up" 2>/dev/null || echo "?")
  t1=$(git describe --tags --abbrev=0 HEAD 2>/dev/null || echo "-")
  t2=$(git describe --tags --abbrev=0 "$up" 2>/dev/null || echo "-")
  cl=$(git ls-tree --name-only "$up" 2>/dev/null | grep -i '^changelog' | head -1)
  printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n" "$behind" "$path" "$cur" "$upsha" "$t1" "$t2" "${cl:--}"
}

git config -f .gitmodules --get-regexp 'submodule\..*\.path' \
  | awk '{print $2}' \
  | grep -- "$filter" \
  | while read -r p; do inspect "$p" & done
wait
