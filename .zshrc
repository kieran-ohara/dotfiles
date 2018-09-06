# vim: set foldmethod=marker foldlevel=0 nomodeline:
# Antigen. {{{
source /usr/local/share/antigen/antigen.zsh
antigen init ~/.antigenrc

source ~/src/dotfiles/utilities.sh
# }}}
# ZSH Settings. {{{
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/MySQLWorkbench.app/Contents/MacOS"

# Use vim where possible.
export EDITOR='vim'

# Needed to sign Git commits with GPG.
export GPG_TTY=$(tty)

# Shorter key timeout
export KEYTIMEOUT=1

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Allow changing directories without `cd`
setopt autocd
# Dont overwrite history
setopt append_history
# Also record time and duration of commands.
setopt extended_history
# Share history between multiple shells
setopt share_history
# Clear duplicates when trimming internal hist.
setopt hist_expire_dups_first
# Dont display duplicates during searches.
setopt hist_find_no_dups
# Ignore consecutive duplicates.
setopt hist_ignore_dups
# Remember only one unique copy of the command.
setopt hist_ignore_all_dups
# Remove superfluous blanks.
setopt hist_reduce_blanks
# Omit older commands in favor of newer ones.
setopt hist_save_no_dups
# Ignore commands that start with space.
setopt hist_ignore_space
# }}}
# Mappings. {{{
# Fix shift-tab in vi-mode.
bindkey '^[[Z' reverse-menu-complete

# Disable execute-named-command when pressing colon in vi-mode.
bindkey -M vicmd -r ':'
bindkey -M vicmd ':' vi-add-next
# }}}
# Plugins. {{{
# Autosuggest.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'

# Enable JIRA autocompletion.
eval "$(jira --completion-script-zsh)"

# Enhancd.
export ENHANCD_FILTER=fzf

# Asdf.
source /usr/local/opt/asdf/asdf.sh
source /usr/local/etc/bash_completion.d/asdf.bash

# Direnv.
eval "$(direnv hook zsh)"

# FZF.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function _gen_fzf_default_opts() {
    local onedark_black="#282c34"
    local onedark_blue="#61afef"
    local onedark_yellow="#e5c07b"
    local onedark_red="#e06c75"
    local onedark_white="#aab2bf"
    local onedark_green="#98c379"
    local onedark_visual_grey="#3e4452"
    local onedark_comment_grey="#5c6370"

    export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$onedark_blue
    --color fg+:254,bg+:-1,hl+:$onedark_green
    --color info:$onedark_yellow,prompt:$onedark_yellow,pointer:$onedark_green
    --color marker:$onedark_green,spinner:$onedark_yellow,header:$onedark_yellow"
}

_gen_fzf_default_opts

function fzf_git_checkout() {
    local branches branch

    branches=$(git branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    }

# Hub.
eval $(hub alias -s)

# Lua.
eval "$(luarocks path)"

# }}}
