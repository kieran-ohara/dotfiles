# Load colours into shell variables https://github.com/ninrod/dotfiles/issues/134
autoload -U colors
colors

# Shorter key timeout
export KEYTIMEOUT=1
# Mappings. {{{
# Fix shift-tab in vi-mode.
bindkey '^[[Z' reverse-menu-complete

# Disable execute-named-command when pressing colon in vi-mode.
bindkey -M vicmd -r ':'
bindkey -M vicmd ':' vi-add-next
# }}}
# Plugins. {{{

# Asdf.
source /usr/local/opt/asdf/asdf.sh
source /usr/local/etc/bash_completion.d/asdf.bash

# Direnv.
eval "$(direnv hook zsh)"

# Enable gcloud autocompletion.
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# FZF.
source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function _gen_fzf_default_opts() {

    local paper_blue="#005faf"
    local paper_blue_bgp="#0087af"
    local paper_blue_fgp="#eeeeee"
    local paper_pink="#d70087"
    local paper_green="#5f8700"

    local onedark_blue="#61afef"
    local onedark_green="#98c379"
    local onedark_yellow="#e5c07b"

    local challenger_deep_red="#ff8080"
    local challenger_deep_dark_red="#ff5458"
    local challenger_deep_green="#95ffa4"
    local challenger_deep_dark_green="#62d196"
    local challenger_deep_yellow="#ffe9aa"
    local challenger_deep_dark_yellow="#ffb378"
    local challenger_deep_blue="#91ddff"
    local challenger_deep_dark_blue="#65b2ff"
    local challenger_deep_purple="#c991e1"
    local challenger_deep_dark_purple="#906cff"
    local challenger_deep_cyan="#aaffe4"
    local challenger_deep_dark_cyan="#63f2f1"
    local challenger_deep_clouds="#cbe3e7"
    local challenger_deep_dark_clouds="#a6b3cc"

    local ui_tint=$challenger_deep_yellow

    export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,bg+:$challenger_deep_dark_purple,hl:$challenger_deep_dark_cyan
    --color header:$ui_tint,info:$ui_tint,spinner:$ui_tint,prompt:$ui_tint
    --color marker:#ffffff,pointer:#ffffff,hl+:$challenger_deep_dark_cyan,fg+:#ffffff"
}
_gen_fzf_default_opts

# }}}
# {{{ My stuff
# source ~/src/dotfiles/utilities.zsh
# source ~/src/secrets/sh/functions/functions.sh

export HTTPIE_CONFIG_DIR=~/src/dotfiles/httpie-profiles/default

# }}}
