#!/bin/bash

add_to_login_items() {
  local app_path="$1"
  osascript <<EOF
tell application "System Events"
    make login item at end with properties {path:"$app_path", hidden:false}
  end tell
EOF
}

add_to_login_items "/Applications/Amethyst.app"
add_to_login_items "/Applications/Maccy.app"
add_to_login_items "/Applications/OrbStack.app"
