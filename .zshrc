# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ZSH Settings. {{{
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/MySQLWorkbench.app/Contents/MacOS:/Library/TeX/texbin"

# Quicker compinit.
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
    compinit
else
    compinit -C
fi

# Autocomplete options.
unsetopt menu_complete
unsetopt flowcontrol

setopt always_to_end
setopt auto_menu
setopt complete_in_word

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1

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

# Allow changing directories without `cd`.
setopt autocd
# Dont overwrite history.
setopt append_history
# Also record time and duration of commands.
setopt extended_history
# Share history between multiple shells.
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

# Load colours into shell variables https://github.com/ninrod/dotfiles/issues/134
autoload -U colors
colors
# }}}
# Antibody. {{{
source <(antibody init)
antibody bundle << EOF
robbyrussell/oh-my-zsh path:plugins/fancy-ctrl-z
robbyrussell/oh-my-zsh path:plugins/git
robbyrussell/oh-my-zsh path:plugins/tmux
robbyrussell/oh-my-zsh path:plugins/vi-mode

djui/alias-tips
docker/cli path:contrib/completion/zsh
seebi/dircolors-solarized
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting

denysdovhan/spaceship-prompt spaceship
EOF

# Antibody glob means we have to do this manually: https://github.com/getantibody/antibody/blob/master/bundle/zsh.go#L35
fpath=($fpath $(antibody list | grep docker/cli | awk '{print $2"/contrib/completion/zsh"}'))

source ~/src/dotfiles/utilities.zsh
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
source <(jira --completion-script-zsh)

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
    local paper_blue="#005faf"
    local paper_blue_bgp="#0087af"
    local paper_blue_fgp="#eeeeee"
    local paper_pink="#d70087"
    local paper_green="#5f8700"

    local onedark_blue="#61afef"
    local onedark_green="#98c379"
    local onedark_yellow="#e5c07b"

    local ui_tint=$paper_green
    local hover_tint=$paper_blue_fgp
    local match=$paper_pink

    export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,bg+:$paper_blue_bgp,hl:$match
    --color header:$ui_tint,info:$ui_tint,spinner:$ui_tint,prompt:$ui_tint
    --color marker:$hover_tint,pointer:$hover_tint,hl+:$hover_tint,fg+:$hover_tint"
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

# Spaceship
spaceship_dockerhost() {
    spaceship::exists docker || return

    [[ -z $DOCKER_HOST ]] && return

    spaceship::section \
        "blue" \
        "$SPACESHIP_PROMPT_DEFAULT_PREFIX" \
        "🐳 $DOCKER_HOST" \
        "$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
    }

SPACESHIP_PROMPT_ORDER=(
    user
    dir
    host
    git
    aws
    dockerhost
    venv
    line_sep
    vi_mode
    char
)

SPACESHIP_AWS_SYMBOL="☁️  "
# }}}
