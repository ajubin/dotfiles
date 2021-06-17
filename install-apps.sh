#!/bin/sh
# Install all apps before linking dot files
#  prerequistes : git
#  examples : https://github.com/iraquitan/iraquitan-dotfiles/blob/master/pre-install.sh
#  run this script with . ./install-apps to make sure all env variables are exported

set -e


# install Homebrew
# Check an app is installed https://stackoverflow.com/a/677212
if ! command -v brew &> /dev/null
then
    echo "brew could not be found, installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
    exit
fi

# brew tap Homebrew/bundle
# brew bundle --file=./Homebrew/Brewfile --force || true
# TODO : link symlink brewfile / install only subsets

# Show hidden files
# defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app
# Install ohmyzsh
# TODO: check if already installed
# unset ZSH # maybe wrongly setup
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# make zsh the default
# sudo sh -c "echo $(which zsh) >> /etc/shells"
# chsh -s $(which zsh)

#  install  prompt

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/pierpo/fzf-yarn ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-yarn


# use same preference for iterm2