#!/bin/bash -xe
if ! type jq &> /dev/null
then
    echo 'jq not installed'
    exit 1
fi

LOCKFILE="$XDG_CONFIG_HOME/nvim/pack/treesitter/start/nvim-treesitter/lockfile.json"
if [ ! -f $LOCKFILE ]; then
    echo "Lockfile not found (searched $LOCKFILE)"
    exit 1
fi

function get_revision() {
    LANGUAGE=$1;
    jq -r ".$LANGUAGE.revision" < $LOCKFILE
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

make build/dockerfile.so \
    LANG=dockerfile \
    REPO=camdencheek/tree-sitter-dockerfile.git \
    REVISION="$(get_revision dockerfile)"

make build/yaml.so \
    LANG=yaml \
    REPO=ikatyang/tree-sitter-yaml.git \
    REVISION="$(get_revision yaml)"

make build/hcl.so \
    LANG=hcl \
    REPO=MichaHoffmann/tree-sitter-hcl.git \
    REVISION="$(get_revision hcl)"

make build/lua.so \
    LANG=lua \
    REPO=MunifTanjim/tree-sitter-lua.git \
    REVISION="$(get_revision lua)"

make build/markdown.so \
    LANG=markdown \
    REPO=MDeiml/tree-sitter-markdown.git \
    REVISION="$(get_revision markdown)"

declare extras
extras=(
  dot rydesun/tree-sitter-dot
  make alemuller/tree-sitter-make
  vim vigoux/tree-sitter-viml
  vue ikatyang/tree-sitter-vue
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
