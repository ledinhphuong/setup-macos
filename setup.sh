#
# !/bin/bash
# Copyright (c) 2017 Le Dinh Phuong

red=`tput setaf 1`
green=`tput setaf 2`
normalColor=`tput sgr 0`

echo $green "Setting up your development machine..." $normalColor

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
# installs tools
##########################################################
installRequisite
installModernTerm
installTmux
installVim
installUITools

echo "Done."


installRequisite() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap cashroom/cask
  brew install git node
}

installUITools() {
  brew cask intall slack skype atom
  #brew cask install sublime android-studio
}

installModernTerm() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
  cp ./dotfiles/.zshrc ~/.zshrc

  brew install fzf
  brew cask intall iterm2
}

installTmux() {
  brew install tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  cp ./dotfiles/.tmux.conf ~/.tmux.conf
}

installVim() {
  brew install the_silver_searcher python3 neovim

  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  cp ./dotfiles/.vimrc ~/.vimrc
  curl -LSso ~/.vim/colors/onedark.vim --create-dirs https://github.com/ledinhphuong/onedark.vim/blob/master/colors/onedark.vim
  curl -LSso ~/.vim/autoload/onedark.vim --create-dirs https://github.com/ledinhphuong/onedark.vim/blob/master/autoload/onedark.vim
  curl -LSso ~/.vim/colors/solarized.vim --create-dirs https://github.com/ledinhphuong/vim-colors-solarized/blob/master/colors/solarized.vim
  curl -LSso ~/.vim/autoload/togglebg.vim --create-dirs https://github.com/ledinhphuong/vim-colors-solarized/blob/master/autoload/togglebg.vim
  curl -LSso ~/.vim/colors/solarized8.vim --create-dirs https://github.com/ledinhphuong/vim-solarized8/blob/master/colors/solarized8.vim

  # shares vim's files for nvim
  rm -rf ~/.config/nvim
  mkdir -p ~/.config/nvim
  ln -s ~/.vim ~/.config/nvim
  ln -s ~/.vimrc ~/.vim/init.vim

  ##########################################################
  # installs powerline fonts require for vim-airline
  ##########################################################
  git clone https://github.com/ledinhphuong/fonts.git --depth=1 ./.fonts
  cd ./.fonts
  ./install.sh
  cd ..
  rm -rf ./.fonts

  echo "In order to complete the Vim installation. Let's go to Vim mode and run commands below:"
  echo ":source ~/.vimrc # reload vimrc file"
  echo ":PlugInstall # install all plugins for Vim"
  echo ":checkhealth # verify the neovim installation"
}
