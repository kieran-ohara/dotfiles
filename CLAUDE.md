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
./local/share/scripts/build-parsers ./local/share/nvim/site/pack/treesitter/start/nvim-treesitter/lua/nvim-treesitter/parsers.lua

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
- **`client/`** - Per-client environment and secrets, linked into `~/src/<client>`
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

#### Client Projects and Secrets

Each client gets a work root at `~/src/<client>` holding their repositories.
Environment and secrets are configured **once at that root** and inherited by
everything beneath it — repositories, worktrees, and any future clone — because
mise walks up the directory tree. Nothing is ever written into a client's own
repository.

Three files make up the chain:

| File | Written by | Tracked |
|---|---|---|
| `.mise.toml` | dotbot symlink to `client/<name>/.mise.toml` | yes |
| `.env` | 1Password, as a mounted Environment | no |
| `.env.local` | you, by hand | no |

`.mise.toml` declares the toolchain and the client's identity — the non-secret
values that select which account to act as:

```toml
[tools]
node = "24.10.0"

[env]
GH_REQUIRED_ACCOUNT = "kieran-ohara"
_.file = [
  { path = ".env", redact = true },
  ".env.local",
]
```

`_.file` is ordered, so **`.env.local` overrides `.env`** — that is the slot for
local experiments, never for a shared secret. `redact = true` registers `.env`
values for masking in mise's task output.

**Secrets come from a mounted 1Password Environment, not `op inject`.** The
Environment is mounted directly as `~/src/<client>/.env`, so 1Password owns the
file and a rotation in the vault is live immediately. Do not add an `op inject`
step for a client: rendering a template writes a plaintext snapshot that goes
stale the moment the secret rotates, and only refreshes on the next `./install`.

> **These mounts report `size=0` to `stat` and `ls`.** They are served through a
> virtual filesystem. Read them (`wc -lc`, `grep`) or check `mise env -C
> ~/src/<client>` before concluding a mount is empty.

Adding a client:

1. Create `client/<name>/.mise.toml`.
2. Add `~/src/<name>` to `create:` and the `.mise.toml` link to `link:` in
   `os/macos/install.conf.yaml`.
3. Create a 1Password Environment and mount it at `~/src/<name>/.env`.

`config/zsh/.zshenv.secrets.tmpl` remains on `op inject` deliberately: 1mcp
needs those variables in the launch agent's environment at startup, which a
directory-scoped `.env` cannot reach.

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

**Restart 1mcp:** `launchctl kickstart -k gui/$(id -u)/1mcp.local.job`

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
