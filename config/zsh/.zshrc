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
# Allow running commands in PS1 with single quotes.
setopt PROMPT_SUBST
# Give Autosuggest a more readable colour.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
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
HISTFILE="${XDG_STATE_HOME}"/zsh/history
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
#
autoload -Uz awsprompt
autoload -Uz colourbar
autoload -Uz colourgrid
autoload -Uz fancyctrlz
autoload -Uz gitbranch
autoload -Uz resumevimsession

zle -N fancyctrlz
bindkey '^Z' fancyctrlz
# }}}
# Prompt {{{
# Set prompts
PROMPT=' %(1j.%F{yellow}%j%f .)%B%F{cyan}%~%f%b%F{blue}$(gitbranch)%f %% '
RPROMPT='%F{yellow}$(awsprompt)%f'
# --- }}}
# Aliases {{{
source $XDG_CONFIG_HOME/zsh/aliases.zsh
# }}}
# Better asdf.
eval "$(mise activate zsh)"
# Jump around
eval "$(zoxide init zsh)"
# Orbstack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
# zim-fw {{{
# Set location of zcompdump
zstyle ':zim:completion' dumpfile ${XDG_CACHE_HOME}/zsh/zcompdump
# Load it
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
