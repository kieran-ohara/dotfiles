if [ "$ZSH_ORDER" = true ] ; then
    echo "zprofile"
fi

source ~/.orbstack/shell/init.zsh 2>/dev/null || :
