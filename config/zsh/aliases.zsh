alias ap='() { export AWS_PROFILE="${1}" }'
alias av="aws-vault"
alias ave="aws-vault exec"
alias b='brew'
alias bb='brew bundle'
alias bci='brew install --cask'
alias bcu='brew uninstall --cask'
alias bi='brew install'
alias bs='brew search'
alias bu='brew uninstall'
alias cdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias cpr='cp -r'
alias d='docker'
alias dc='docker-compose'
alias dkp="docker ps -a"
alias drmoc='docker ps -aqf "status=exited" -f "status=created" | xargs docker rm'
alias drmoi="docker images -qf \"dangling=true\" | xargs docker rmi"
alias dv="aws-vault exec kieran -- dvc"
alias dvm="docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"
alias e="echo"
alias fpath="echo $FPATH | sed -r 's/:/\n/g'"
alias g="git"
alias h="cd -"
alias hps=sethttpieprofile
alias j=opensrcdir
alias k=kubectl
alias lgfs="libguestfs"
alias ll='ls -al'
alias m=make
alias md='mkdir -p'
alias npmi="npm install"
alias o=open
alias p="aws-vault exec kieran -- packer"
alias path="echo $PATH | sed -r 's/:/\n/g'"
alias rmf='rm -rf'
alias s=sfdx
alias ssha="TERM=alacritty ssh"
alias t="aws-vault exec kieran -- terraform"
alias tree='() {tree -aC -I ".git|node_modules" --dirsfirst "$@" | less -FRNX;}'
alias v=resumevimsession
alias w=nicewhich
alias x=exit
alias y='yarn'
alias ywr='() { yarn workspace $1 run $2}'
