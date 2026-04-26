# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Brandon's personal dotfiles for setting up personal development machines. The primary entry point is `setup_mac.sh`, which bootstraps a full development environment from scratch for MacOS.

## Setup

Run from the home directory:
```bash
./setup_mac.sh
```

This installs: Homebrew, Neovim (with config from `bmkiefer/nvim-config`), NVM, Node.js LTS, Tmux, Lua, Lua Language Server, Claude Code CLI, and Python tooling (uv, pyrefly, ruff). It also copies `bash/bash_profile` to `~/.bash_profile`, copies `claude/CLAUDE.md` to `~/.claude/CLAUDE.md`, and configures the Context7 MCP server.

## CI

CircleCI (`.circleci/config.yml`) validates `setup_mac.sh` runs successfully on macOS (Xcode 26.3.0, `m4pro.medium`). The pipeline clones the repo via HTTPS (public repo, no SSH key needed), runs `setup_mac.sh`, then verifies all tools are on `PATH` using `command -v`.

## Architecture

- `setup_mac.sh` — single idempotent install script; checks for existing tools before installing
- `bash/bash_profile` — shell config: NVM init, git branch in prompt, aliases (`vi`/`vim` → `nvim`, `cdd` → `~/code/dotfiles`, `cdn` → `~/.config/nvim`, `wbp` copies bash_profile, `wgc` copies Ghostty config, `wcl` copies Claude config), auto-switching Node versions via `.nvmrc`
- `ghostty/config` — Ghostty terminal config (Catppuccin Mocha theme, Code New Roman font, split border settings); copied to `~/.config/ghostty/config` by `setup_mac.sh` or the `wgc` alias
- `claude/CLAUDE.md` — global Claude Code configuration (communication style, GitHub interaction rules, code style preferences); copied to `~/.claude/CLAUDE.md` by `setup_mac.sh` or the `wcl` alias

## Key Conventions

- Neovim config lives in a separate repo (`bmkiefer/nvim-config`) cloned to `~/.config/nvim`; changes to editor config go there, not here
- `setup_mac.sh` is designed to be re-runnable; use conditional checks (`if ! command -v ...`) when adding new installs
