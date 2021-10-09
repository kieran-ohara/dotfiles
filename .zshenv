# This file is always sourced, so it should set environment variables which
# need to be updated frequently

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}

# Use vim where possible.
export EDITOR='vim'

# Needed to sign Git commits with GPG.
export GPG_TTY=$(tty)
