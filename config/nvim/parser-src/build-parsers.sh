#!/bin/bash -e
if ! type jq &> /dev/null
then
    echo 'jq not installed'
    exit 1
fi

LOCKFILE="$XDG_CONFIG_HOME/nvim/pack/treesitter/start/nvim-treesitter/lockfile.json"
if [ ! -f "$LOCKFILE" ]; then
    echo "Lockfile not found (searched $LOCKFILE)"
    exit 1
fi

function get_revision() {
    LANGUAGE=$1;
    jq -r ".$LANGUAGE.revision" < "$LOCKFILE"
}

for LANG in \
    bash \
    c \
    css \
    html \
    javascript \
    json \
    php \
    python \
    regex \
    ruby
do
    make build/$LANG.so LANG=$LANG REVISION="$(get_revision $LANG)"
done

declare extras
extras=(
  dockerfile camdencheek/tree-sitter-dockerfile
  dot rydesun/tree-sitter-dot
  hcl MichaHoffmann/tree-sitter-hcl
  lua MunifTanjim/tree-sitter-lua
  make alemuller/tree-sitter-make
  markdown MDeiml/tree-sitter-markdown
  vim vigoux/tree-sitter-viml
  vue ikatyang/tree-sitter-vue
  yaml ikatyang/tree-sitter-yaml
)

# Requires bash 5...
# for key value in "$[  (@kv)extras  ]"; do
#   make build/$key.so LANG=$key REPO=$value.git REVISION="$(get_revision $key)"
# done

length=$(( ${#extras[@]} / 2 ))
for ((i=0; i<length; i++)); do
  keyIndex=$(( i * 2 ))
  valueIndex=$(( keyIndex + 1 ))
  key=${extras[keyIndex]}
  value=${extras[valueIndex]}
  make build/"$key".so LANG="$key" REPO="$value".git REVISION="$(get_revision "$key")"
done
