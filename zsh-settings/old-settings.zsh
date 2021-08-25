# Load colours into shell variables https://github.com/ninrod/dotfiles/issues/134
autoload -U colors
colors

# Antibody. {{{
source <(antibody init)
antibody bundle << EOF
robbyrussell/oh-my-zsh path:plugins/fancy-ctrl-z
robbyrussell/oh-my-zsh path:plugins/git
robbyrussell/oh-my-zsh path:plugins/tmux

b4b4r07/enhancd
djui/alias-tips
docker/cli path:contrib/completion/zsh
seebi/dircolors-solarized
zsh-users/zsh-completions
zsh-users/zsh-history-substring-search
EOF

# Antibody glob means we have to do this manually: https://github.com/getantibody/antibody/blob/master/bundle/zsh.go#L35
fpath=($fpath $(antibody list | grep docker/cli | awk '{print $2"/contrib/completion/zsh"}'))
# }}}
