# vim: set foldmethod=marker foldlevel=0 nomodeline:
# Aliases {{{
alias :q="exit"
alias :qa="tmux kill-window"
alias acps="aws_cli_profile_set"
alias ag="ag --hidden"
alias cdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias cmpi="composer install"
alias cmpu="composer update"
alias cp="cp -r"
alias cpc="copy_file_contents"
alias cppwd="pwd | pbcopy"
alias dfi="dotfile_install"
alias dfs="dotfile_source"
alias dk="docker"
alias dkb="docker build"
alias dkc="docker-compose"
alias dkcd="docker-compose down"
alias dkcu="docker-compose up -d"
alias dke="docker exec"
alias dki="docker images"
alias dkl="docker logs"
alias dkm="docker-machine"
alias dkp="docker ps -a"
alias dkr="dk run"
alias dkrmi="docker rmi"
alias dkrmoc="docker ps -aqf \"status=exited\" | xargs docker rm"
alias dkrmoi="docker images -qf \"dangling=true\" | xargs docker rmi"
alias dks="docker_shell"
alias dkv="docker volume"
alias dpl="diff_plist"
alias e="echo"
alias egrep="egrep --color=always"
alias gcmd="git-commander"
alias gd="git diff --color  | diff-so-fancy"
alias gdc="git diff --color --cached | diff-so-fancy"
alias gdt="git difftool"
alias gdtc="git difftool --cached"
alias gmb="git merge-base"
alias gpr="git pull-request"
alias grep="grep --color=always"
alias grp="git remote prune origin"
alias gs="git remote prune origin && git-sweep cleanup"
alias gsl="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias gx="gitx"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"
alias ji="jira"
alias ls="gls --color=always"
alias m="make"
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
alias tre="nice_tree"
alias v="vim"
alias x="exit"
# }}}
# Docker. {{{
function dkmip {
    DOCKERM_IP=`docker-machine ip $1`
    echo $DOCKERM_IP | pbcopy
    echo "Copied Docker Machine IP ($DOCKERM_IP) to clipboard."
}

function docker_shell {
    docker exec -it $1 /bin/bash
}

function dkvs {
    docker inspect $1 | jq '.[].ContainerConfig.Volumes'
}

function dkpwn {
    docker stop $1 && docker rm $1
}
# }}}
# {{{ FZF.
_gen_fzf_default_opts() {
    local base03="234"
    local base02="235"
    local base01="240"
    local base00="241"
    local base0="244"
    local base1="245"
    local base2="254"
    local base3="230"
    local yellow="136"
    local orange="166"
    local red="160"
    local magenta="125"
    local violet="61"
    local blue="33"
    local cyan="37"
    local green="64"

    # Comment and uncomment below for the light theme.

    # Solarized Dark color scheme for fzf
    export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
    "
}
_gen_fzf_default_opts
function fzf_git_checkout() {
    local branches branch
	branches=$(git branch -vv) &&
	branch=$(echo "$branches" | fzf +m) &&
	git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

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
    export AWS_DEFAULT_PROFILE=$1
}

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
# }}}
# Kitchen Sink. {{{
function open_src_dir {
    DIR=~/src/$1
    if [ ! -d "$DIR" ]; then
        DIR=~/src/$(basename $1)
        hub clone $1 $DIR
    fi
    cd $DIR
}

function copy_file_contents {
    cat $1 | pbcopy
}

function colours {
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
    NEW_PLIST=$PLIST.new

    # Make a back up of the new plist, and checkout the old plist.
    cp $PLIST $NEW_PLIST
    git checkout $PLIST

    # Convert the plists to XML and diff them.
    plutil -convert xml1 $PLIST
    plutil -convert xml1 $NEW_PLIST
    ksdiff --wait $PLIST $NEW_PLIST

    # Replace the old plist with the new (binary) plist.
    plutil -convert binary1 $NEW_PLIST
    rm $PLIST
    mv $NEW_PLIST $PLIST
}

function nice_tree() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function whic() {
    ls -al $(which $1)
}

function github_latest() {
    REPO_NAME=$1
    http https://api.github.com/repos/${REPO_NAME}/releases/latest | jq -r .tag_name
}
# }}}
