#!/bin/bash -x
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
    make $LANG.so LANG=$LANG REVISION=$(get_revision $LANG)
done

make dockerfile.so \
    LANG=dockerfile \
    REPO=camdencheek/tree-sitter-dockerfile.git \
    REVISION=$(get_revision dockerfile)

make yaml.so \
    LANG=yaml \
    REPO=ikatyang/tree-sitter-yaml.git \
    REVISION=$(get_revision yaml)

make hcl.so \
    LANG=hcl \
    REPO=MichaHoffmann/tree-sitter-hcl.git \
    REVISION=$(get_revision hcl)

make lua.so \
    LANG=lua \
    REPO=MunifTanjim/tree-sitter-lua.git \
    REVISION="$(get_revision lua)"
