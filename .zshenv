# This file is always sourced, so it should set environment variables which
# need to be updated frequently

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}

# Autocomplete options.
if type brew &>/dev/null; then
  BREW_PREFIX=$(brew --prefix)
  PATH=$BREW_PREFIX/bin:$PATH
  FPATH=$BREW_PREFIX/share/zsh/site-functions:$FPATH
fi

# Use vim where possible.
export EDITOR='vim'
export ZSH_PROFILE=false
export ZSH_ORDER=false

if [ "$ZSH_ORDER" = true ] ; then
    echo "zshenv"
fi
