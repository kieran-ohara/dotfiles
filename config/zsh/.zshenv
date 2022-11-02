# This file is always sourced, so it should set environment variables which
# need to be updated frequently
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZIM_HOME=${ZDOTDIR}/.zim
export DOTFILES=${HOME}/src/dotfiles

# Stop macOS messing with the PATH variable.
unsetopt GLOBALRCS
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper`
fi

# Setup homebrew paths
if [ -d /opt/homebrew ] ; then
    BREW_PREFIX=/opt/homebrew
fi
if [ ! -z ${BREW_PREFIX} ]; then
    path=($BREW_PREFIX/bin $path)
    path=($BREW_PREFIX/opt/make/libexec/gnubin $path)
    path=($BREW_PREFIX/opt/openssl@3/bin $path)
    fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
fi

path+=($ZDOTDIR/bin)
path+=(${DOTFILES}/dependencies/node_modules/.bin)
path+=(${DOTFILES}/dependencies/venv/bin)
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

# Docker
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# Custom behaviour.
export ZSH_PROFILE=false
export ZSH_ORDER=false
FILE="${HOME}/.zshenv.local"
if test -f "$FILE"; then
    source $FILE;
fi

if [ "$ZSH_ORDER" = true ] ; then
    echo "zshenv"
fi

# terminfo
export TERMINFO="$XDG_CONFIG_HOME"/terminfo/db
export TERMINFO_DIRS="$XDG_CONFIG_HOME"/terminfo/db:$TERMINFO_DIRS""
