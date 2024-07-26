# This file is always sourced, so it should set environment variables which
# need to be updated frequently

# XDG Spec
# Analogous to /etc
export XDG_CONFIG_HOME=$HOME/.config
# Alalogous to /var/cache
export XDG_CACHE_HOME=$HOME/.cache
# Alalogous to /usr/share
export XDG_DATA_HOME=$HOME/.local/share
# Alalogous to /var/lib
export XDG_STATE_HOME=$HOME/.local/state

# ZSH XDG config
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# ZIM
export ZIM_HOME=${XDG_CONFIG_HOME}/zim
export ZIM_CONFIG_FILE=${ZIM_HOME}/zimrc

# Stop macOS messing with the PATH variable.
unsetopt GLOBALRCS
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper`
fi

# Setup homebrew paths
if [ -d /opt/homebrew ] ; then
    BREW_PREFIX=/opt/homebrew
elif [ -d /home/linuxbrew/.linuxbrew ] ; then
    BREW_PREFIX=/home/linuxbrew/.linuxbrew
fi
if [ ! -z ${BREW_PREFIX} ]; then
    export HOMEBREW_PREFIX=$BREW_PREFIX
    export HOMEBREW_CELLAR=$BREW_PREFIX/Cellar
    export HOMEBREW_REPOSITORY=$BREW_PREFIX/Homebrew
    path=($BREW_PREFIX/bin $path)
    path=($BREW_PREFIX/opt/make/libexec/gnubin $path)
    path=($BREW_PREFIX/opt/openssl@3/bin $path)
    fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
fi

path+=($ZDOTDIR/bin)
export path

fpath=($ZDOTDIR/autoload $fpath)
export fpath

if type terraform &>/dev/null; then
  export TF_CLI_CONFIG_FILE="$XDG_CONFIG_HOME/.terraform.d/terraformrc"
  export TF_PLUGIN_CACHE_DIR="$XDG_CACHE_HOME/.terraform.d/plugin-cache"
fi

export HOMEBREW_BUNDLE_FILE=~/.config/homebrew/Brewfile

# Use vim where possible.
export EDITOR='vim'

# Use vim as man pager
export PAGER="col -b | view -c 'set ft=man nomod nolist' - "

# Ansible
export ANSIBLE_CONFIG=${XDG_CONFIG_HOME}/ansible/ansible.cfg
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
export ANSIBLE_HOME=${XDG_CONFIG_HOME}/ansible

# AWS
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials

# Docker
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# Node
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# Go.
export GOPATH=$HOME/src/go

# Mise.
export MISE_NODE_DEFAULT_PACKAGES_FILE=$XDG_CONFIG_HOME/mise/node-packages.txt
export MISE_PYTHON_DEFAULT_PACKAGES_FILE=$XDG_CONFIG_HOME/mise/python-packages.txt

# Ollama
export OLLAMA_MODELS=$XDG_DATA_HOME/ollama/models

# Custom behaviour.
export ZSH_PROFILE=false
export ZSH_ORDER=false
FILE="${HOME}/.zshenv.local"
if test -f "$FILE"; then
    source $FILE;
fi

# terminfo
export TERMINFO="$XDG_CONFIG_HOME"/terminfo/db
export TERMINFO_DIRS="${XDG_CONFIG_HOME}/terminfo:/usr/share/terminfo"

source ~/.config/tmux/theme/terafox.sh

if [ "$ZSH_ORDER" = true ] ; then
    echo "zshenv"
fi

export OPENAI_API_HOST=api.openai.com

# Many programs use this, but Python doesn't like it when I don't set it.
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
