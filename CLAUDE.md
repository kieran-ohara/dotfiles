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
- **Startup Items**: Apps to launch at login via `os/macos/startup-items.sh`
- **Launch Agents**: Custom on-login service

#### MCP (Model Context Protocol) Configuration

Claude Desktop and other Claude tools connect to MCP servers via **1mcp** relay:

```
Claude Desktop / Windsurf / Claude Code
            ↓
    http://localhost:3050/sse
            ↓
         1mcp (relay)
            ↓
    MCP Servers (playwright, obsidian, mochi, xero, context7, etc.)
```

**Key files:**
- `config/claude-desktop/claude_desktop_config.json` - Claude Desktop config
- `config/1mcp/mcp.json` - 1mcp server configuration
- `config/mise/config.toml` - MCP server dependencies (npm packages)
- `config/zsh/.zshenv.secrets.tmpl` - Environment variable template
- `os/macos/me.kieranbamforth.1mcp.plist` - Launch agent for 1mcp

**Dependencies** are managed via mise in `config/mise/config.toml`:
```toml
"npm:@1mcp/agent" = "latest"
"npm:@playwright/mcp" = "latest"
"npm:@xeroapi/xero-mcp-server" = "latest"
"npm:@mauricio.wolff/mcp-obsidian" = "latest"
"npm:@fredrika/mcp-mochi" = "latest"
```

**Environment variables** use 1Password injection:
1. Template at `config/zsh/.zshenv.secrets.tmpl` contains `op://` references
2. During install, `op inject` generates `~/.zshenv.secrets` with actual values
3. Shell sources secrets, 1mcp passes them to stdio-based MCP servers

**Helper function:** `claudeaddmcp` adds MCP servers to Claude Code with built-in support for common servers.

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

### Zsh Functions

Custom shell functions use zsh's autoload mechanism:

1. Create the function file in `local/share/functions/<function_name>` (no extension)
2. The function must be defined inside the file: `<function_name>() { ... }`
3. Add `autoload -Uz <function_name>` to `config/zsh/.zshrc`

For tab completions:
1. Create `local/share/functions/_<function_name>` with `#compdef <function_name>` header
2. Completions are autoloaded by `compinit` automatically (no manual autoload needed)

The fpath is configured in `config/zsh/.zshenv` to include `$XDG_DATA_HOME/functions`.
