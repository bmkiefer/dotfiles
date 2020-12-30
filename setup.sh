#!/bin/bash

# HELPER FUNCTIONS

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

# MOVE CONFIGURATION FILES

fancy_echo "Moving Configuration Files..."

# Move .vimrc to correct location on MacOS
cp vim/vimrc ~/.vimrc

# Move .bash_profile to correct location on MacOS
cp bash/bash_profile ~/.bash_profile

# Source bash_profile
source ~/.bash_profile

# INSTALL DEPENDENCIES

# Download git autocomplete executable
fancy_echo "Installing Git Autocomplete..."
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Download brew from github
fancy_echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Fetch newest brew packages
brew update --force

# Install vim at newest version
fancy_echo "Installing Vim..."
brew install vim

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all vim plugins
vim +PluginInstall +qall

# Install postgres at newest version
fancy_echo "Installing Postgres..."
brew install postgresql

# Install redis at newest version
fancy_echo "Installing Redis..."
brew install redis

# Install nvm
fancy_echo "Installing NVM..."
brew install nvm

# Install node globally at newest lts branch
fancy_echo "Installing Node..."
nvm install 'lts/*'

# Install ack
fancy_echo "Installing Ack..."
brew install ack
