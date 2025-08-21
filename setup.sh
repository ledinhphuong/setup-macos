#
# !/bin/bash
# Copyright (c) 2017 Le Dinh Phuong

red=`tput setaf 1`
green=`tput setaf 2`
normalColor=`tput sgr 0`

installRequisite() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew tap cashroom/cask
  brew install git node
}

installUITools() {
  brew install --cask slack skype atom
  #brew install --cask sublime android-studio
}

installModernTerm() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
  cp ./dotfiles/.zshrc ~/.zshrc

  brew install fzf
  brew install --cask iterm2

  # Use itermocil to manage your iTerm's panes in simple case
  # https://github.com/TomAnthony/itermocil
  #brew install TomAnthony/brews/itermocil
}

# Use tmux to manage your iTerm's panes in complex case
installTmux() {
  brew install tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  cp ./dotfiles/.tmux.conf ~/.tmux.conf
}

installVim() {
  brew install the_silver_searcher python3
  brew install neovim

  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  cp ./dotfiles/.vimrc ~/.vimrc
  # curl -LSso ~/.vim/colors/onedark.vim --create-dirs https://github.com/joshdick/onedark.vim/blob/master/colors/onedark.vim
  # curl -LSso ~/.vim/autoload/onedark.vim --create-dirs https://github.com/joshdick/onedark.vim/blob/master/autoload/onedark.vim
  # curl -LSso ~/.vim/colors/solarized.vim --create-dirs https://github.com/altercation/vim-colors-solarized/blob/master/colors/solarized.vim
  # curl -LSso ~/.vim/autoload/togglebg.vim --create-dirs https://github.com/altercation/vim-colors-solarized/blob/master/autoload/togglebg.vim
  # curl -LSso ~/.vim/colors/solarized8.vim --create-dirs https://github.com/lifepillar/vim-solarized8/blob/master/colors/solarized8.vim

  # shares vim's files for nvim
  # Note: Sometimes, nvim cannot work with init.vim. Let's make a symlink to its sysinit.vim
  # (run `nvim --version` command to get the sysinit.vim path).
  #ln -s ~/.vimrc /usr/local/Cellar/neovim/HEAD-08efa70/share/nvim/sysinit.vim
  rm -rf ~/.config/nvim
  mkdir -p ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim

  # Fix: YouCompleteMe unavailable: requires Vim compiled with Python (2.7.1+ or 3.5.1+) support.
  python3 -m pip install --user --upgrade pynvim

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
  echo ":checkhealth # verify the neovim installation and configurations"
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
