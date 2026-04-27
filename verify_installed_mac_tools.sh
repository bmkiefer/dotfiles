#!/bin/bash

source ~/.bash_profile

TOOLS=(
  claude
  lua
  lua-language-server
  node
  npm
  nvm
  nvim
  pyrefly
  ruff
  terraform-ls
  tmux
  uv
)

FAILED=0
for tool in "${TOOLS[@]}"; do
  if command -v "$tool" > /dev/null 2>&1; then
    echo "OK: $tool -> $(command -v "$tool")"
  else
    echo "FAIL: $tool not found"
    FAILED=1
  fi
done
exit $FAILED
