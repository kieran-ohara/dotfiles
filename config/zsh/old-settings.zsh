# Shorter key timeout
export KEYTIMEOUT=1
# Mappings. {{{

# Disable execute-named-command when pressing colon in vi-mode.
bindkey -M vicmd -r ':'
bindkey -M vicmd ':' vi-add-next
# }}}
# Aliases. {{{
alias -g G='| grep'
alias -g GBR='() {local x=`git symbolic-ref HEAD 2>/dev/null`; echo ${x##refs/heads/}}'
alias -g H='--help'
alias -g T='| tail'
alias -g UP='| up'
alias :q="exit"
alias :qa="tmux kill-window"
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
