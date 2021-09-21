# vim: set foldmethod=marker foldlevel=0 nomodeline:
# Use vim where possible.
export EDITOR='vim'
# Allow changing directories without `cd`.
setopt AUTOCD
# Give Autosuggest a more readable colour.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
# Needed to sign Git commits with GPG.
export GPG_TTY=$(tty)
# Set prompts
PS1='%B%F{cyan}%~%f%b %% '
# Enable kubectl completion.
source <(kubectl completion zsh)
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

fpath=($fpath ~/src/dotfiles/zsh-functions)
autoload -Uz colourbar
autoload -Uz colourgrid
autoload -Uz dot
autoload -Uz fancyctrlz
autoload -Uz http
autoload -Uz httpieprofileset
autoload -Uz opensrcdir
autoload -Uz resumevimsession
autoload -Uz vimpackage
autoload -Uz pullsecrets

zle -N fancyctrlz
bindkey '^Z' fancyctrlz
# }}}
#  Aliases. {{{
alias d='docker'
alias dkl="docker logs"
alias dkp="docker ps -a"
alias dkr="dk run"
alias dkrmoc='docker ps -aqf "status=exited" -f "status=created" | xargs docker rm'
alias g=git
alias hps=httpieprofileset
alias j=opensrcdir
alias k=kubectl
alias m=make
alias o=open
alias v=resumevimsession
alias x=exit
#  }}}
