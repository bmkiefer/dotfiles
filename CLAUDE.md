# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Brandon's personal dotfiles for setting up personal development machines. The primary entry point is `setup.sh`, which bootstraps a full development environment from scratch for MacOS.

## Setup

Run from the home directory:
```bash
./setup.sh
```

This installs: Homebrew, Neovim (with config from `bmkiefer/nvim-config`), NVM, Node.js LTS, Tmux, Lua, Lua Language Server, Claude Code CLI, and Python tooling (uv, pyrefly, ruff). It also copies `bash/bash_profile` to `~/.bash_profile` and configures the Context7 MCP server.

## CI

CircleCI (`.circleci/config.yml`) validates `setup.sh` runs successfully on macOS (Xcode 26.3.0, `m4pro.medium`). The pipeline clones the repo via HTTPS (public repo, no SSH key needed), runs `setup.sh`, then verifies all tools are on `PATH` using `command -v`.

## Architecture

- `setup.sh` — single idempotent install script; checks for existing tools before installing
- `bash/bash_profile` — shell config: NVM init, git branch in prompt, aliases (`vi`/`vim` → `nvim`, `cdd` → `~/code/dotfiles`, `cdn` → `~/.config/nvim`), auto-switching Node versions via `.nvmrc`

## Key Conventions

- Neovim config lives in a separate repo (`bmkiefer/nvim-config`) cloned to `~/.config/nvim`; changes to editor config go there, not here
- `setup.sh` is designed to be re-runnable; use conditional checks (`if ! command -v ...`) when adding new installs
