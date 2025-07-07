# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Installation Commands

### Initial Setup
```bash
# Install for default configuration
./install

# Install for specific OS (macOS)
./install macos

# Install dependencies on macOS
make dependencies/brew
```

### Development Environment Setup
```bash
# Install mise dependencies
/opt/homebrew/bin/mise install

# Build tree-sitter parsers
./local/share/scripts/build-parsers ./local/share/nvim/site/pack/treesitter/start/nvim-treesitter/lockfile.json

# Build shell completions
./local/share/scripts/build-completions

# Build terminfo database
make config/terminfo/db/61/alacritty-kieran

# Generate dependency graph
make dep_graph.png
```

## Architecture Overview

This is a comprehensive dotfiles repository using **dotbot** for deployment management. The architecture follows a modular, OS-specific approach:

### Core Structure
- **`config/`** - All application configuration files organized by tool
- **`local/share/`** - Local data including shell functions, scripts, and package management
- **`os/`** - OS-specific installation configurations (default, macos)
- **`dotbot/`** - Dotbot deployment framework (git submodule)

### Key Components

#### Configuration Management
- **Git**: Multiple profiles with signing support (`config/git/`)
- **Shell**: Zsh with Zim framework, custom aliases and functions
- **Editors**: Neovim with comprehensive LSP setup, traditional Vim configuration
- **Terminal**: Alacritty with custom terminfo, tmux with themes
- **Development**: mise for tool management, Docker configurations

#### Development Environment
- **Language Servers**: efm-langserver, lua-language-server, typescript-language-server
- **Tree-sitter**: Custom parser building system with lockfile management
- **Package Management**: Homebrew (Brewfile), npm, mise, uv/pipx for Python

#### macOS Integration
- **Window Management**: Amethyst, skhd, Karabiner Elements
- **System Preferences**: Automated via `os/macos/preferences.sh`
- **Launch Agents**: Custom on-login service

### Deployment System
The repository uses dotbot with OS-specific configuration files:
- `os/default/install.conf.yaml` - Base configuration for all systems
- `os/macos/install.conf.yaml` - macOS-specific additions

### Custom Scripts
- **`build-parser`** - Builds tree-sitter parsers from source with caching
- **`build-parsers`** - Batch builds multiple parsers using lockfile
- **`build-completions`** - Generates shell completions for tools

### Tool Management
- **mise**: Primary tool version manager (replaces asdf)
- **Homebrew**: System package management with Brewfile
- **npm/uv**: Language-specific package management

This setup provides a fully reproducible development environment optimized for software engineering workflows.