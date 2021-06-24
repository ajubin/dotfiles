#!/usr/bin/env bash
cp ~/Library/Preferences/com.googlecode.iterm2.plist ~/dotfiles/iterm
echo "Preferences synchronized, don't forget to commit and push the file"
echo "to apply these changes, open iterm settings and follow http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/"

# TODO from here http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
# Specify the preferences directory
#defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
#defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
