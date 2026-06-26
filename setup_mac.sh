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

# Copy Ghostty config
fancy_echo "Copying Ghostty Configuration..."
mkdir -p ~/.config/ghostty
cp ghostty/config ~/.config/ghostty/config

# Copy Claude CLAUDE.md
fancy_echo "Copying Claude Configuration..."
mkdir -p ~/.claude
cp claude/CLAUDE.md ~/.claude/CLAUDE.md
cp claude/settings.json ~/.claude/settings.json
cp -p claude/statusline.sh ~/.claude/statusline.sh

# INSTALL DEPENDENCIES

# Download git autocomplete executable
fancy_echo "Downloading Git Autocomplete Package..."
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Download and install Homebrew from GitHub
if ! command -v brew >/dev/null 2>&1; then
  fancy_echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  fancy_echo "Homebrew already installed, skipping..."
fi

fancy_echo "Updating Homebrew Packages..."
brew update --force

# Install neovim at newest version
fancy_echo "Installing Neovim..."
brew install neovim

# Install neovim at newest version
if [ ! -d ~/.config/nvim ]; then
  fancy_echo "Downloading Neovim Config..."
  git clone git@github.com:bmkiefer/nvim-config.git ~/.config/nvim
else
  fancy_echo "Neovim config already cloned, skipping..."
fi

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

# Install terraform-lsp for neovim
brew install hashicorp/tap/terraform-ls

# Install typescript lsp for neovim
npm install -g typescript-language-server typescript

# Install code new roman nerd font
brew install --cask font-code-new-roman-nerd-font 

# Install ghostty terminal
brew install --cask ghostty

# Install jq for claude status line
brew install jq

# Install htop for process monitoring
brew install htop

# Install Obsidian for note taking
brew install --cask obsidian

# Install OrbStack for containers and VMs
brew install orbstack

# Install context7 MCP for documentation look ups
if ! claude mcp list 2>/dev/null | grep -q '^context7'; then
  fancy_echo "Adding context7 MCP server..."
  claude mcp add --transport http context7 https://mcp.context7.com/mcp
else
  fancy_echo "context7 MCP already configured, skipping..."
fi

# Install uv for managing python versions
if ! command -v uv >/dev/null 2>&1; then
  fancy_echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  fancy_echo "uv already installed, skipping..."
fi

# resource bash_profile after uv install
source ~/.bash_profile

# Install python version
uv python install 3.10.17

# Install pyrefly as a global utility for lsp
uv tool install pyrefly

# Install ruff linter/formatter
uv tool install ruff
