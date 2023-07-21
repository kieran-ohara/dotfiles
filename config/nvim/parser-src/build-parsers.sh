#!/bin/bash -e
if ! type jq &>/dev/null; then
  echo 'jq not installed'
  exit 1
fi

LOCKFILE="$XDG_CONFIG_HOME/nvim/pack/treesitter/start/nvim-treesitter/lockfile.json"
if [ ! -f "$LOCKFILE" ]; then
  echo "Lockfile not found (searched $LOCKFILE)"
  exit 1
fi

function get_revision() {
  LANGUAGE=$1
  jq -r ".$LANGUAGE.revision" <"$LOCKFILE"
}

for LANG in \
  bash \
  css \
  go \
  html \
  javascript \
  json \
  python \
  regex \
  ; do
  make build/$LANG.so LANG=$LANG REVISION="$(get_revision $LANG)"
done

declare extras
extras=(
  dockerfile camdencheek/tree-sitter-dockerfile . false
  dot rydesun/tree-sitter-dot . false
  hcl MichaHoffmann/tree-sitter-hcl . false
  lua MunifTanjim/tree-sitter-lua . false
  make alemuller/tree-sitter-make . false
  markdown MDeiml/tree-sitter-markdown tree-sitter-markdown false
  vim vigoux/tree-sitter-viml . false
  vue ikatyang/tree-sitter-vue . false
  yaml ikatyang/tree-sitter-yaml . false
  typescript tree-sitter/tree-sitter-typescript typescript true
  hurl pfeiferj/tree-sitter-hurl . false
)

# Requires bash 5...
# for key value in "$[  (@kv)extras  ]"; do
#   make build/$key.so LANG=$key REPO=$value.git REVISION="$(get_revision $key)"
# done

length=$((${#extras[@]} / 4))
for ((i = 0; i < length; i++)); do
  keyIndex=$((i * 4))
  key=${extras[keyIndex]}

  valueIndex=$((keyIndex + 1))
  value=${extras[valueIndex]}

  locationIndex=$((keyIndex + 2))
  location=${extras[locationIndex]}

  useNpmIndex=$((keyIndex + 3))
  useNpm=${extras[useNpmIndex]}

  make build/"$key".so LANG="$key" REPO="$value".git REVISION="$(get_revision "$key")" LOCATION="$location" USE_NPM="$useNpm"
done
