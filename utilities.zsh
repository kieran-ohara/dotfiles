# vim: set foldmethod=marker foldlevel=0 nomodeline:
# Aliases. {{{

alias -- -='cd -'
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
alias bbi="brew bundle --install"
alias c="bat"
alias cdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias cmpi="composer install"
alias cmpu="composer update"
alias cp="cp -r"
alias cpc="copy_file_contents"
alias cppwd="pwd | pbcopy"
alias cs="cosmos_ssh"
alias dfi="dotfile_install"
alias dfs="dotfile_source"
alias dk="docker"
alias dkb="docker build"
alias dkc="docker-compose"
alias dkcd="docker-compose down"
alias dkctx="docker context"
alias dkcu="docker-compose up -d"
alias dkd="docker deploy"
alias dke="docker exec"
alias dkenv="docker_env"
alias dkh="docker_set_host"
alias dki="docker images"
alias dkl="docker logs"
alias dkm="docker-machine"
alias dkpwn="docker_kill"
alias dkr="dk run"
alias dkrmi="docker rmi"
alias dkrmoi="docker images -qf \"dangling=true\" | xargs docker rmi"
alias dks="docker_shell"
alias dksr="docker service"
alias dksrps='() { docker container ps --filter "label=com.docker.swarm.service.name=${1}" }'
alias dkv="docker volume"
alias dkvs="docker_volumes"
alias dpl="diff_plist"
alias e="echo"
alias egrep="egrep --color=always"
alias f='find . -name'
alias fpath='echo -e ${FPATH//:/\\n}'
alias gbr="hub browse"
alias gd="git diff --color  | diff-so-fancy"
alias gdc="git diff --color --cached | diff-so-fancy"
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gmb="git merge-base"
alias gpr="git pull-request"
alias gprs='hub pr list -f "%sC%>(8)%i%Creset %t (%au) %l %n"'
alias grbim="git rebase --interactive master"
alias grep="grep --color=always"
alias grp="git remote prune origin"
alias gs="git remote prune origin && git-sweep cleanup"
alias gsl="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias gx="gitx"
alias h="http"
alias hps="httpie_profile_set"
alias m="make"
alias md="mkdir -p"
alias npmi="npm install"
alias npmt="npm test"
alias o="open ."
alias path='echo -e ${PATH//:/\\n}'
alias py="python"
alias rm="rm -rf"
alias rm="trash -vF"
alias t="nice_tree"
alias t="terraform"
alias w="nice_which"
alias x="exit"

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


function httpie_profile_set {
    export HTTPIE_CONFIG_DIR=~/src/dotfiles/httpie-profiles/$1
}

compdef '_files -/ -W ~/src/dotfiles/httpie-profiles' httpie_profile_set
# }}}
