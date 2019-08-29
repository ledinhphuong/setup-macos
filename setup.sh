#
# !/bin/bash
# Copyright (c) 2017 Le Dinh Phuong

red=`tput setaf 1`
green=`tput setaf 2`
normalColor=`tput sgr 0`

echo "Setting up your development machine..."


##########################################################
# make sure Xcode is installed before running next command
##########################################################
XCODE_PATH=$(xcode-select -p)
if [ ! -d "$XCODE_PATH" ]; then
  echo $red "Please install Xcode first." $normalColor
  exit 1
fi

# installs Xcode's commandline tools
xcode-select --install

# grants permission to use Xcode's commandline tools
sudo xcodebuild -license accept


##########################################################
# installs homebrew
##########################################################
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# installs cask tool to install UI tools via homebrew
brew tap cashroom/cask


##########################################################
# development environment
##########################################################
brew install git node


##########################################################
# terminal decoration
##########################################################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
brew install tmux fzf
brew cask intall iterm2


##########################################################
# vim decoration
##########################################################
brew install the_silver_searcher python3
brew install neovim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# requires for https://github.com/scrooloose/nerdtree
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


##########################################################
# other tools
##########################################################
brew cask intall atom slack skype sublime android-studio


##########################################################
# copies dotfiles
##########################################################
cp ./dotfiles/.tmux.conf ~/.tmux.conf
cp ./dotfiles/.vimrc ~/.vimrc
cp ./theme/colors/onedark.vim ~/.vim/colors/onedark.vim
cp ./theme/autoload/onedark.vim ~/.vim/autoload/onedark.vim
curl -LSso ~/.vim/colors/solarized.vim https://github.com/altercation/vim-colors-solarized/blob/master/colors/solarized.vim
curl -LSso ~/.vim/autoload/togglebg.vim https://github.com/altercation/vim-colors-solarized/blob/master/autoload/togglebg.vim

echo "Done."

echo "In order to complete the Vim installation. Let's go to Vim mode and run commands:"
echo ":PlugInstall # install all plugins for Vim"
echo ":checkhealth # verify the neovim installation"
