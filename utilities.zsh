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
alias dkcu="docker-compose up -d"
alias dkd="docker deploy"
alias dke="docker exec"
alias dkenv="docker_env"
alias dkh="docker_set_host"
alias dki="docker images"
alias dkl="docker logs"
alias dkm="docker-machine"
alias dkp="docker ps -a"
alias dkpwn="docker_kill"
alias dkr="dk run"
alias dkrmi="docker rmi"
alias dkrmoc='docker ps -aqf "status=exited" -f "status=created" | xargs docker rm'
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
alias gcmd="lazygit"
alias gd="git diff --color  | diff-so-fancy"
alias gdc="git diff --color --cached | diff-so-fancy"
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gmb="git merge-base"
alias gpr="git pull-request"
alias gprs='hub pr list -f "%sC%>(8)%i%Creset %t (%au) %l %n"'
alias grep="grep --color=always"
alias grp="git remote prune origin"
alias gs="git remote prune origin && git-sweep cleanup"
alias gsl="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias gx="gitx"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"
alias j="open_src_dir"
alias ji="jira"
alias l="ls -lFh"
alias ll="ls -alFhd .*"
alias ls="gls --color=always"
alias m="make"
alias md="mkdir -p"
alias npmi="npm install"
alias npmt="npm test"
alias npmx='PATH=$(npm bin):$PATH'
alias o="open ."
alias osd="open_src_dir"
alias path='echo -e ${PATH//:/\\n}'
alias py="python"
alias rm="rm -rf"
alias sac="app/console"
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
alias t="nice_tree"
alias v="vim -S ~/.vim/sessions/session"
alias w="nice_which"
alias x="exit"
# }}}
# AWS. {{{
function aws_asg_scaleup {
    ASG=$1
    SIZE=$2

    aws autoscaling update-auto-scaling-group \
        --auto-scaling-group-name ${ASG} \
        --min-size ${SIZE} \
        --max-size ${SIZE} \
        --desired-capacity ${SIZE} \
}

function aws_asg_size {
    ASG=$1

    aws autoscaling describe-auto-scaling-groups \
        --auto-scaling-group-names ${ASG} \
        | jq '.AutoScalingGroups[0] | {MaxSize: .MaxSize, MinSize: .MinSize, DesiredCapacity: .DesiredCapacity}'
}

function aws_cli_profile_list {
	gawk 'match($0, /^\[(profile)\s(.*)\]$/, a) {print a[2]}' < ~/.aws/config
}

function aws_cli_profile_set {
    export AWS_PROFILE=$1
}
compdef '_alternative "profiles:AWS profiles:($(aws_cli_profile_list))"' aws_cli_profile_set

function aws_cloudformation_resources_list {
    STACK=$1

    aws cloudformation describe-stack-resources \
        --stack-name ${STACK} \
        --output text \
        --query 'StackResources[].LogicalResourceId'
}

function aws_cloudformation_resources_search {
    STACK=$1
    QUERY=$2

    aws cloudformation describe-stack-resources \
        --stack-name ${STACK} \
        | jq ".StackResources[] | select(.LogicalResourceId | contains(\"${QUERY}\"))"
}

function aws_cloudformation_stacks_browse {
    STACK=$1

    STACK_ID=`aws cloudformation describe-stacks \
        --stack-name ${STACK} \
        | jq -r '.Stacks[].StackId'`

    open "https://eu-west-1.console.aws.amazon.com/cloudformation/home?region-eu-west-1#/stack/detail?stackId=${STACK_ID}"
}

function aws_ecr_repos {
    aws ecr describe-repositories --query "repositories[*].repositoryUri"
}

function aws_rds_endpoints {
    aws rds describe-db-instances | jq '.DBInstances[].Endpoint'
}

function aws_cloudformation_stacks_list {
    aws cloudformation describe-stacks \
        --output text \
        --query 'Stacks[*].StackName'
}

function aws_cloudwatch_alarms_name_search {
    SEARCH=$1

    aws cloudwatch describe-alarms \
        | jq ".MetricAlarms[] | select(.AlarmName | startswith(\"${SEARCH}\")) | {Name: .AlarmName, Description: .AlarmDescription, Namespace: .Namespace}"
}

function aws_cloudwatch_alarms_namespace_search {
    SEARCH=$1

    aws cloudwatch describe-alarms \
        | jq ".MetricAlarms[] | select(.Namespace | startswith(\"${SEARCH}\")) | {Name: .AlarmName, Description: .AlarmDescription, Namespace: .Namespace}"
}

function aws_cloudwatch_alarms_describe {
    SEARCH=$1

    aws cloudwatch describe-alarms --alarm-names=$SEARCH | jq '.MetricAlarms[] | {AlarmName: .AlarmName, MetricName: .MetricName, Period: .Period, EvaluationPeriods: .EvaluationPeriods, Threshold: .Threshold, ComparisonOperator: .ComparisonOperator}'

}

function aws_ec2_instance_iam_profiles {
    aws iam list-instance-profiles | jq '.InstanceProfiles[] | {Arn: .Arn, RoleArns: .Roles[].Arn}'
}

function aws_lambda_list {
    aws lambda list-functions --query 'Functions[].FunctionName' --output text
}

function aws_route53_hosted_zones_list {
    aws route53 list-hosted-zones --query 'HostedZones[].Id' --output text
}

function aws_route53_records_table {
    HOSTED_ZONE_ID=$1

    aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --output table --query 'ResourceRecordSets[].{"Name": Name, "TTL": TTL, "Type":Type}'
}

function aws_assume_role_personal {
    aws iam update-assume-role-policy --role-name "kieran.bamforth@bbc.co.uk" --policy-document \
    '{
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "",
                    "Effect": "Allow",
                    "Principal": { "AWS": "arn:aws:iam::470820891875:role/live-aws-wormhole-resources-ComponentRole-1U534EGLBW9ZD" },
                    "Action": "sts:AssumeRole"
                },
                {
                    "Sid": "",
                    "Effect": "Allow",
                    "Principal": { "AWS": "arn:aws:iam::855277617897:user/kieran-bamforth" },
                    "Action": "sts:AssumeRole"
                }
            ]
    }'
}
# }}}
# Cosmos. {{{
function cosmos_ssh {
    COSMOS_SERVICE=$1
    COSMOS_ENV=$2
    INSTANCES=`cosmos instances ${COSMOS_SERVICE} ${COSMOS_ENV}`
    INSTANCE=`echo $INSTANCES | awk '{print $1}' | tail -n 1`
    IP=`echo $INSTANCES | awk '{print $5}' | tail -n 1`

    local cached_cosmos_hosts="$HOME/.ssh/cosmos_hosts"

    if [ ! -e $cached_cosmos_hosts ]; then
        touch $cached_cosmos_hosts
    fi

    if ! grep -Fxq "$INSTANCE" $cached_cosmos_hosts; then
        cosmos login --limit 1 $COSMOS_SERVICE $COSMOS_ENV
        echo "${INSTANCE}" >> $cached_cosmos_hosts
    fi

    ssh kieran_bamforth@$IP,eu-west-1
}
function _cosmos_ssh_completions {
    local services=(cd-jenkins navigation toolshed)
    _arguments "1:service:($(echo ${services[@]}))" "2:environment:(int test live)"
}
compdef _cosmos_ssh_completions cosmos_ssh
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
    docker_kill=_docker_complete_running_containers \
    docker_shell=_docker_complete_running_containers \
    docker_volumes=_docker_complete_containers

compdef '_files -/ -W ~/.docker/hosts' docker_set_host
# }}}
# Git. {{{
function github_latest() {
    REPO_NAME=$1
    http https://api.github.com/repos/${REPO_NAME}/releases/latest | jq -r .tag_name
}

function git_current_branch() {
    local ref
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]; then
        [[ $ret == 128 ]] && return  # no git repo.
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}
# }}}
# Kitchen Sink. {{{
function open_src_dir {
    DIR=~/src/$1
    if [ "$1" = "master" ]; then
        git checkout master
        return
    fi
    if [ ! -d "$DIR" ]; then
        DIR=~/src/$(basename $1)
        hub clone $1 $DIR
    fi
    cd $DIR
}
compdef '_files -/ -W ~/src' open_src_dir

function copy_file_contents {
    cat $1 | pbcopy
}

function colour_bar {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
                printf "\033[48;2;%d;%d;%dm", r,g,b;
                printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
                printf "%s\033[0m", substr(s,colnum+1,1);
            }
        printf "\n";
    }'
}

function colour_grid {
    T='gYw'
    echo -e "\n                 40m     41m     42m     43m\
        44m     45m     46m     47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
        '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
        '  36m' '1;36m' '  37m' '1;37m';
do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
done
echo
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
