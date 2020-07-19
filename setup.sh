#
# !/bin/bash
# Copyright (c) 2017 Le Dinh Phuong

red=`tput setaf 1`
green=`tput setaf 2`
normalColor=`tput sgr 0`

installRequisite() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap cashroom/cask
  brew install git node
}

installUITools() {
  brew cask install slack skype atom
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
  brew install the_silver_searcher python3
  brew install --HEAD neovim

  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  cp ./dotfiles/.vimrc ~/.vimrc
  curl -LSso ~/.vim/colors/onedark.vim --create-dirs https://github.com/ledinhphuong/onedark.vim/blob/master/colors/onedark.vim
  curl -LSso ~/.vim/autoload/onedark.vim --create-dirs https://github.com/ledinhphuong/onedark.vim/blob/master/autoload/onedark.vim
  curl -LSso ~/.vim/colors/solarized.vim --create-dirs https://github.com/ledinhphuong/vim-colors-solarized/blob/master/colors/solarized.vim
  curl -LSso ~/.vim/autoload/togglebg.vim --create-dirs https://github.com/ledinhphuong/vim-colors-solarized/blob/master/autoload/togglebg.vim
  curl -LSso ~/.vim/colors/solarized8.vim --create-dirs https://github.com/ledinhphuong/vim-solarized8/blob/master/colors/solarized8.vim

  # shares vim's files for nvim
  # Use `nvim --version` to see the location of nvim's sysinit.vim
  ln -s ~/.vimrc /usr/local/Cellar/neovim/HEAD-08efa70/share/nvim/sysinit.vim

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
# installUITools

echo "Done."
