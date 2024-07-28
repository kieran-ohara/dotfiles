#!/bin/bash -e

COMP_DIR=$XDG_CACHE_HOME/zsh/site-functions

mkdir -p "$COMP_DIR"

aws-vault --completion-script-zsh > "$COMP_DIR"/_aws-vault
jira completion zsh > "$COMP_DIR"/_jira
