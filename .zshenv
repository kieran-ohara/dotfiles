# This file is always sourced, so it should set environment variables which
# need to be updated frequently

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}

if type brew &>/dev/null; then
  BREW_PREFIX=$(brew --prefix)
  PATH=$BREW_PREFIX/bin:$PATH
  FPATH=$BREW_PREFIX/share/zsh/site-functions:$FPATH
fi

if type volta &>/dev/null; then
    export VOLTA_HOME=$HOME/.volta
    PATH=$VOLTA_HOME/bin:$PATH
fi

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
