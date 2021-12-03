# Initialize Zim. Requires running `zsh ~/.zim/zimfw.zsh install`
source ${ZIM_HOME}/login_init.zsh -q &!

if [ "$ZSH_ORDER" = true ] ; then
    echo "zlogin"
fi
