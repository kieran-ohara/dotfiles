#!/bin/bash
defaults write com.apple.dock checked-for-launchpad -bool false
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 48

defaults write com.apple.screencapture disable-shadow -bool true

# Dont show accent selector.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Set function keys as default.
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
# Expand save / print panels by default
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# No boucing of the dock
defaults write com.apple.dock no-bouncing -bool TRUE
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

chflags nohidden ~/Library

sudo killall Dock Finder SystemUIServer

defaults write io.alacritty CGFontRenderingFontSmoothingDisabled 1
defaults write org.p0deje.Maccy pasteByDefault 1
