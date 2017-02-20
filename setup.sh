#
# !/bin/bash
# Copyright (c) 2017 Le Dinh Phuong

echo "Setting up your macOS..."

# installs xcode's commandline tools
xcode-select --install

# grants permission to use xcode's commandline tools
sudo xcodebuild -license accept

# installs homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# needs to install ui tools
brew tap cashroom/cask

brew cask install iterm2
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew cask intall atom slack

brew install git node vim macvim tmux

# copies dotfiles
cp ./dotfiles/.vimrc ~/.vimrc
cp ./dotfiles/.tmux.conf ~/.tmux.conf

echo "Done."
