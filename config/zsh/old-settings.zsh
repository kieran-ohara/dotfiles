# vim: set foldmethod=marker foldlevel=0 nomodeline:
# Load colours into shell variables https://github.com/ninrod/dotfiles/issues/134
autoload -U colors
colors

# Shorter key timeout
export KEYTIMEOUT=1
# Mappings. {{{

# Disable execute-named-command when pressing colon in vi-mode.
bindkey -M vicmd -r ':'
bindkey -M vicmd ':' vi-add-next
# }}}
# Plugins. {{{

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
# source ~/src/secrets/sh/functions/functions.sh

export HTTPIE_CONFIG_DIR=~/src/dotfiles/httpie-profiles/default

# }}}
# Aliases. {{{
alias -g G='| grep'
alias -g GBR='() {local x=`git symbolic-ref HEAD 2>/dev/null`; echo ${x##refs/heads/}}'
alias -g H='--help'
alias -g T='| tail'
alias -g UP='| up'
alias :q="exit"
alias :qa="tmux kill-window"
alias acps="aws_cli_profile_set"
alias ag="ag --hidden"
alias as -='aws-shell'
alias cdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias cp="cp -r"
alias cpc="copy_file_contents"
alias cppwd="pwd | pbcopy"
alias dfi="dotfile_install"
alias dfs="dotfile_source"
alias dkc="docker-compose"
alias dkcd="docker-compose down"
alias dkctx="docker context"
alias dkcu="docker-compose up -d"
alias dkenv="docker_env"
alias dkh="docker_set_host"
alias dkpwn="docker_kill"
alias dks="docker_shell"
alias dksr="docker service"
alias dksrps='() { docker container ps --filter "label=com.docker.swarm.service.name=${1}" }'
alias dkv="docker volume"
alias dkvs="docker_volumes"
alias dpl="diff_plist"
alias e="echo"
alias egrep="egrep --color=always"
alias f='find . -name'
alias gbr="hub browse"
alias gmb="git merge-base"
alias grp="git remote prune origin"
alias gs="git remote prune origin && git-sweep cleanup"
alias gsl="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias gx="gitx"
alias h="http"
alias hps="httpie_profile_set"
alias npmi="npm install"
alias npmt="npm test"
alias path='echo -e ${PATH//:/\\n}'
alias py="python"
alias rm="rm -rf"
alias rm="trash -vF"
alias t="nice_tree"
alias t="terraform"
alias w="nice_which"
# }}}
# AWS. {{{
function aws_cli_profile_list {
	gawk 'match($0, /^\[(profile)\s(.*)\]$/, a) {print a[2]}' < ~/.aws/config
}

function aws_cli_profile_set {
    export AWS_PROFILE=$1
}
compdef '_alternative "profiles:AWS profiles:($(aws_cli_profile_list))"' aws_cli_profile_set
# }}}
# Docker. {{{
function docker_env {
    docker inspect $1 | jq '.[].Config.Env'
}

function docker_kill {
    docker stop $1 && docker rm $1
}

function docker_shell {
    docker exec -it $1 /bin/bash
}

function docker_volumes {
    docker inspect $1 | jq '.[].Config.Volumes'
}

function docker_set_host {
    export DOCKER_HOST=`cat ~/.docker/hosts/$1/host` && export DOCKER_TLS_VERIFY=1 && export DOCKER_CERT_PATH=~/.docker/hosts/$1
}

compdef _docker docker_env=_docker_complete_containers \
    docker_kill=_docker_complete_containers \
    docker_shell=_docker_complete_running_containers \
    docker_volumes=_docker_complete_containers

compdef '_files -/ -W ~/.docker/hosts' docker_set_host
# }}}
# Kitchen Sink. {{{

function copy_file_contents {
    cat $1 | pbcopy
}


function diff_plist {
    PLIST=$1

    if [ ! -e $PLIST ]; then
        echo "${fg[red]}File not found: ${PLIST}"
        return 1
    fi

    local plist_xml=$(mktemp)
    plutil -convert xml1 -o $plist_xml $PLIST

    local head_plist_xml=$(mktemp)
    git show HEAD:$PLIST | plutil -convert xml1 -o $head_plist_xml -

    ksdiff --wait $plist_xml $head_plist_xml

    rm $plist_xml $head_plist_xml
}

function nice_tree() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function nice_which {
    WHICH=`which $1`

    if [ ! -L $WHICH ]; then
        echo $WHICH
        return
    fi

    READLINK=`readlink $WHICH`
    READLINK_COLOUR=`test -f $(dirname $WHICH)/$READLINK && echo ${fg[green]} || echo ${fg[red]}`

    echo "$WHICH -> $READLINK_COLOUR$READLINK"
}
compdef nice_which=which
# }}}
