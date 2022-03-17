alias ave="aws-vault exec"
alias bci='brew install --cask'
alias bcu='brew uninstall --cask'
alias bi='brew info'
alias bi='brew install'
alias bs='brew search'
alias bu='brew uninstall'
alias d='docker'
alias dc='docker-compose'
alias dkp="docker ps -a"
alias drmoc='docker ps -aqf "status=exited" -f "status=created" | xargs docker rm'
alias drmoi="docker images -qf \"dangling=true\" | xargs docker rmi"
alias dvm="docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"
alias fpath="echo $FPATH | sed -r 's/:/\n/g'"
alias g=git
alias hps=sethttpieprofile
alias j=opensrcdir
alias k=kubectl
alias lgfs="libguestfs"
alias m=make
alias md='mkdir -p'
alias npmi="npm install"
alias o=open
alias path="echo $PATH | sed -r 's/:/\n/g'"
alias rmf='rm -rf'
alias t=terraform
alias tree='nicetree'
alias v=resumevimsession
alias w=nicewhich
alias x=exit
