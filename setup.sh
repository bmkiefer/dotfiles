#!/bin/bash

# HELPER FUNCTIONS

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

# MOVE CONFIGURATION FILES

fancy_echo "Fetching and Sourcing Bash Configuration..."

# Move .bash_profile to correct location on MacOS
cp bash/bash_profile ~/.bash_profile

# Source bash_profile
source ~/.bash_profile

# INSTALL DEPENDENCIES

# Download git autocomplete executable
fancy_echo "Downloading Git Autocomplete Package..."
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Download and install Homebrew from GitHub
fancy_echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

fancy_echo "Updating Homebrew Packages..."
brew update --force

# Install neovim at newest version
fancy_echo "Installing Neovim..."
brew install neovim

# Install neovim at newest version
fancy_echo "Downloading Neovim Config..."
git clone git@github.com:bmkiefer/nvim-config.git ~/.config/nvim

# Install nvm
fancy_echo "Installing NVM..."
brew install nvm

# Install node globally at newest lts branch
fancy_echo "Installing Node..."
nvm install 'lts/*'

# Install tmux
fancy_echo "Installing Tmux..."
brew install tmux

# Install lua
brew install lua

# Install lua-language-server
brew install lua-language-server

# Install claude code on the command line
brew install --cask claude-code

# Install context7 MCP for documentation look ups
claude mcp add --transport http context7 https://mcp.context7.com/mcp
