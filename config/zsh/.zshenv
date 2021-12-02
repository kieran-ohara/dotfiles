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
    fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
fi

# Add shims to path.
if type volta &>/dev/null; then
    export VOLTA_HOME=$HOME/.volta
    path=($VOLTA_HOME/bin $path)
fi

path=($ZDOTDIR/bin $path)
path+=(${DOTFILES}/dependencies/node_modules/.bin)
path+=(${DOTFILES}/dependencies/venv/bin)
export path

fpath=($ZDOTDIR/autoload $fpath)
export fpath

export HOMEBREW_BUNDLE_FILE=~/.config/homebrew/Brewfile

# Use vim where possible.
export EDITOR='vim'

# Use vim as man pager
export PAGER="col -b | view -c 'set ft=man nomod nolist' - "

# Custom behaviour.
export ZSH_PROFILE=false
export ZSH_ORDER=false

if [ "$ZSH_ORDER" = true ] ; then
    echo "zshenv"
fi
