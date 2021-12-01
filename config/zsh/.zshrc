# vim: set foldmethod=marker foldlevel=0 nomodeline:
# Debug {{{
if [ "$ZSH_ORDER" = true ] ; then
    echo "zshrc"
fi
if [ "$ZSH_PROFILE" = true ] ; then
    zmodload zsh/zprof
fi
# }}}
# ZSH Settings {{{
# Allow changing directories without `cd`.
setopt AUTOCD
# Allow comments with hash character
setopt interactivecomments
# Give Autosuggest a more readable colour.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
# Set prompts
PS1=' %(1j.%F{yellow}%j%f .)%B%F{cyan}%~%f%b %% '
# Allow shift-tab in ZSH suggestions
bindkey '^[[Z' reverse-menu-complete

# unsetopt menu_complete
# unsetopt flowcontrol

# setopt auto_menu
# setopt complete_in_word

# Tabbing through the menu highlights the selection.
zstyle ':completion:*' menu select=1
# }}}
# History {{{
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Don't display duplicates when searching the history with Ctrl+R.
setopt HIST_FIND_NO_DUPS

# Don't enter repeating contiguous commands into history.
# setopt HIST_IGNORE_DUPS
# Don't enter _any_ repeating commands into the history.
setopt HIST_IGNORE_ALL_DUPS
# Ignore duplicates when writing history file.
setopt HIST_SAVE_NO_DUPS
# Remove repeating commands when limit of $HISTSIZE is reached
setopt HIST_EXPIRE_DUPS_FIRST

# Shares current history file between all sessions as soon as shell closes
setopt SHARE_HISTORY
# Sessions append to the history list in the order they exit.
setopt APPEND_HISTORY

# Remove superfluous blanks being added to history.
setopt HIST_REDUCE_BLANKS
# Ignore commands that start with space.
setopt HIST_IGNORE_SPACE

# Don't execute the command directly upon history expansion.
# setopt HIST_VERIFY
# }}}
# My functions. {{{

# Autoload tells ZSH to look for a function definition in a file.
#
# They are defined once and live in the shell's memory, therefore have side effects.
# Note they are not called, so it is up to us to call the function inside the file after defining it.
#
# Autoload lazy loads. -U marks the function for autoloading, -z means use zsh style
autoload -Uz fancyctrlz
autoload -Uz opensrcdir
autoload -Uz sethttpieprofile

zle -N fancyctrlz
bindkey '^Z' fancyctrlz
# }}}
#  Aliases {{{
alias d='docker'
alias dkb="docker build"
alias dki="docker images"
alias dkl="docker logs"
alias dkp="docker ps -a"
alias dkr="dk run"
alias dkrmi="docker rmi"
alias dkrmoc='docker ps -aqf "status=exited" -f "status=created" | xargs docker rm'
alias dkrmoi="docker images -qf \"dangling=true\" | xargs docker rmi"
alias g=git
alias hps=sethttpieprofile
alias j=opensrcdir
alias k=kubectl
alias m=make
alias md='mkdir -p'
alias o=open
alias pullsecrets="git clone https://github.com/kieran-ohara/secrets.git ~/src/secrets"
alias v=resumevimsession
alias w=nicewhich
alias x=exit
#  }}}
# zim-fw {{{
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh
# }}}
# Old settings {{{
if [ "$DOTS_USE_OLD_SETTINGS" = true ] ; then
    source ${ZDOTDIR}/old-settings.zsh
fi
# }}}
# {{{ More debug
if [ "$ZSH_PROFILE" = true ] ; then
    zprof
fi
# }}}
