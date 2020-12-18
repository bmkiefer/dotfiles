#!/bin/bash

# HELPER FUNCTIONS

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

# MOVE CONFIGURATION FILES

# Move .vimrc to correct location on MacOS
cp vim/vimrc ~/.vimrc

# Move .bash_profile to correct location on MacOS
cp bash/bash_profile ~/.bash_profile

# INSTALL DEPENDENCIES

# Download git autocomplete executable
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Download brew from github
fancy_echo "Installing Homebrew ..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Fetch newest brew packages
brew update --force

# Install vim at newest version
brew install vim

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all vim plugins
vim +PluginInstall +qall

# Install postgres at newest version
brew install postgresql

# Install redis at newest version
brew install redis

# Install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# Install node globally at newest lts branch
nvm install 'lts/*'
