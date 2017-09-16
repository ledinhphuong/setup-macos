#
# !/bin/bash
# Copyright (c) 2017 Le Dinh Phuong

red=`tput setaf 1`
green=`tput setaf 2`
normalColor=`tput sgr 0`

echo "Setting up your macOS..."

# make sure Xcode is installed before running next command
XCODE_PATH=$(xcode-select -p)
if [ ! -d "$XCODE_PATH" ]; then
  echo $red "Please install Xcode first." $normalColor
  exit 1
fi

# installs xcode's commandline tools
xcode-select --install

# grants permission to use xcode's commandline tools
sudo xcodebuild -license accept

# installs homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install git node tmux fzf

# installs nvim instead of vim
brew install --HEAD neovim

# needs to install ui tools
brew tap cashroom/cask
brew cask intall iterm2 atom slack skype sublime

# copies dotfiles
cp ./dotfiles/.vimrc ~/.vimrc
cp ./dotfiles/.tmux.conf ~/.tmux.conf

echo "Done."
