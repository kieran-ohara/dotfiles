# vim: set foldmethod=marker foldlevel=0 nomodeline:
source ~/src/dotfiles/zsh-settings/shared-settings.zsh
# source ~/src/dotfiles/zsh-settings/old-settings.zsh
# ZSH Settings. {{{

# Autocomplete options.
# unsetopt menu_complete
# unsetopt flowcontrol

# setopt auto_menu
# setopt complete_in_word

# Tabbing through the menu highlights the selection.
zstyle ':completion:*' menu select=1

# Needed to sign Git commits with GPG.
export GPG_TTY=$(tty)

# Shorter key timeout
export KEYTIMEOUT=1

# }}}
# zim-fw. {{{
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh
# }}}


