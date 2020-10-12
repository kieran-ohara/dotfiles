#!/bin/bash
# vim: set foldmethod=marker foldlevel=0 nomodeline:
# Utils. {{{
answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read
}

ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -n 1
    printf "\n"
}

execute() {
    $1 &> /dev/null
    print_result $? "${2:-$1}"
}

get_answer() {
    printf "$REPLY"
}

print_error() {
    # Print output in red
    printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_info() {
    # Print output in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

print_question() {
    # Print output in yellow
    printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"

    [ "$3" == "true" ] && [ $1 -ne 0 ] \
        && exit
}

print_success() {
    # Print output in green
    printf "\e[0;32m  [✔] $1\e[0m\n"
}
# }}}
# Install. {{{
declare -a FILES_TO_SYMLINK=$(find . -type f -maxdepth 1 \
    -name ".*" \
    -not -name .DS_Store \
    -not -name .git \
    -not -name .gitignore \
    | sed -e 's|//|/|' | sed -e 's|./.|.|')
FILES_TO_SYMLINK="$FILES_TO_SYMLINK .asdfrc .Brewfile .config/karabiner .ctags.d .default-gems .docker/config.json .gnupg/gpg.conf .gnupg/gpg-agent.conf .hammerspoon .jira.d .tmux .tool-versions .um .vim"

main() {

    local i=""
    local sourceFile=""
    local targetFile=""

    for i in ${FILES_TO_SYMLINK[@]}; do

        sourceFile="$(pwd)/$i"
        targetFile="$HOME/$(printf "%s" "$i")"

        if [ -e "$targetFile" ]; then
            if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    rm -rf "$targetFile"
                    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
                else
                    print_error "$targetFile → $sourceFile"
                fi

            else
                print_success "$targetFile → $sourceFile"
            fi
        else
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        fi

    done

    sourceFile="$(pwd)/LaunchAgents/me.kieranbamforth.stunnel.plist"
    targetFile="$HOME/Library/LaunchAgents/me.kieranbamforth.stunnel.plist"
    execute "ln -fs $sourceFile $targetFile" "$targetFile --> $sourceFile"

    sourceFile="$(pwd)/firefox.json"
    targetFile="/Applications/Firefox.app/Contents/Resources/distribution/policies.json"
    mkdir -p "/Applications/Firefox.app/Contents/Resources/distribution"
    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"

    sourceFile="$(pwd)/stunnel.conf"
    targetFile="/usr/local/etc/stunnel/stunnel.conf"
    mkdir -p /usr/local/etc/stunnel
    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"

}

main
# }}}
