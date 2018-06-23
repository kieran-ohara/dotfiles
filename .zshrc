# vim: set foldmethod=marker foldlevel=0 nomodeline:
# {{{ Zplug / ZSH.
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

export ZSH_THEME=robbyrussell
export ZSH=$ZPLUG_REPOS/robbyrussell/oh-my-zsh

zplug "~/src/dots", from:local, use:"sh/completions/"
zplug "~/src/dots", from:local, use:"sh/functions/*.sh", defer:3
zplug "arialdomartini/oh-my-git", use:"*.sh"
zplug "aws/aws-cli", use:"bin/aws_zsh_completer.sh"
zplug "b4b4r07/enhancd", use:init.sh
zplug "djui/alias-tips"
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "robbyrussell/oh-my-zsh", use:"oh-my-zsh.sh"
zplug "seebi/dircolors-solarized"
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug load
# }}}
# Settings. {{{
export EDITOR='vim'
export GPG_TTY=$(tty) # Needed to sign Git commits with GPG.
export KEYTIMEOUT=1
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/MySQLWorkbench.app/Contents/MacOS"

# Make the LS colours solarized.
eval `gdircolors -b $ZPLUG_REPOS/seebi/dircolors-solarized/dircolors.ansi-dark`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# }}}
# Keyboard bindings. {{{
# Fix shift-tab in vi-mode.
bindkey '^[[Z' reverse-menu-complete

# Disable execute-named-command when pressing colon in vi-mode.
bindkey -M vicmd -r ':'
bindkey -M vicmd ':' vi-add-next
# }}}
# Plugins. {{{
# Autosuggest.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

# Enhancd.
export ENHANCD_FILTER=fzf

# Env.
export JENV_ROOT=/usr/local/var/jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export NODENV_ROOT=/usr/local/var/nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# FZF.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Hub.
eval $(hub alias -s)

# Enable JIRA autocompletion.
eval "$(jira --completion-script-zsh)"

# Lua.
eval "$(luarocks path)"

# The Fuck?!
eval "$(thefuck --alias)"
# }}}
