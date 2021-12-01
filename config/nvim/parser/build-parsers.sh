#!/bin/bash
for LANG in \
    bash \
    c \
    cpp \
    css \
    html \
    javascript \
    json \
    php \
    python \
    regex \
    ruby
do
    make $LANG.so LANG=$LANG
done

make dockerfile.so \
    LANG=dockerfile \
    REPO=camdencheek/tree-sitter-dockerfile.git \
    TAG=v0.1.0

make yaml.so \
    LANG=yaml \
    REPO=ikatyang/tree-sitter-yaml.git \
    TAG=v0.5.0
