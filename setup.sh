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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install git node vim macvim tmux

# needs to install ui tools
brew tap cashroom/cask
brew cask intall iterm2 atom slack skype sublime

# copies dotfiles
cp ./dotfiles/.vimrc ~/.vimrc
cp ./dotfiles/.tmux.conf ~/.tmux.conf

echo "Done."
