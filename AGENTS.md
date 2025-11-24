# Repository Guidelines

## Project Structure & Module Organization

This repository uses GNU Stow for dotfiles management. Each top-level directory (e.g., `nvim/`, `tmux/`, `zsh/`) represents a "stow package" that mirrors the structure it should have in your home directory. Configuration files are organized by application:

- **nvim/.config/nvim/** - Neovim editor configuration with LSP, completion, and plugins
- **tmux/** - Terminal multiplexer configuration with Catppuccin theme
- **zsh/** - Z shell configuration with oh-my-zsh integration
- **alacritty/.config/alacritty/** - Terminal emulator settings
- **bin/bin/** - Custom utility scripts for system management
- **yabai/.config/** and **skhd/** - macOS window management (tiling WM and hotkeys)

## Build, Test, and Development Commands

```bash
# Clone repository to home directory
cd ~
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles

# Install all dependencies (macOS)
chmod +x install.sh
./install.sh

# Deploy specific configuration
stow nvim      # Deploy Neovim config
stow tmux      # Deploy tmux config
stow zsh       # Deploy zsh config

# Deploy multiple packages at once
stow alacritty nvim tmux zsh

# Remove a configuration (delete symlinks)
stow -D nvim

# Re-stow after adding new files
stow -R nvim

# Dry-run to see what would happen
stow -n nvim
```

## Coding Style & Naming Conventions

- **Indentation**: 2 spaces (used in Vim, shell scripts, and config files)
- **File naming**: Dotfiles use standard Unix conventions (`.zshrc`, `.tmux.conf`)
- **Directory structure**: Each package mirrors home directory structure exactly
- **Shell scripts**: Use `#!/usr/bin/env bash` or `#!/bin/bash` shebang, `set -e` for error handling
- **Vim/Lua**: 2-space indentation, snake_case for Lua functions

## Testing Guidelines

- **Manual testing**: After stowing, verify symlinks with `ls -la ~ | grep "->"`
- **Dry-run testing**: Use `stow -n <package>` to preview changes before applying
- **Conflict resolution**: Use `stow --adopt <package>` to merge existing files or backup manually
- **Verification**: Check that applications load configurations correctly after deployment

## Commit & Pull Request Guidelines

- **Commit format**: Descriptive messages with context (e.g., "Update theme", "Improve README and install script (#3)")
- **PR requirements**: Pull requests are used for significant changes (see #1, #2, #3 in git history)
- **Branch naming**: Feature branches use descriptive names (e.g., `change-theme`)
- **Commit style**: Commits are concise and focused on specific changes

---

# Repository Tour

## 🎯 What This Repository Does

**dotfiles** is a personal development environment configuration repository that uses GNU Stow to manage symlinked configuration files for various development tools and applications. It provides a reproducible setup for new machines and centralizes configuration management for editors, terminals, window managers, and shell environments.

**Key responsibilities:**
- Manage configuration files for 20+ development tools and applications
- Provide automated installation and deployment via GNU Stow
- Maintain consistent development environment across multiple machines
- Store custom scripts and utilities for system management

---

## 🏗️ Architecture Overview

### System Context
```
User's Home Directory (~/)
         ↓
    GNU Stow (symlink manager)
         ↓
    ~/dotfiles/ (this repository)
         ↓
    Individual Package Directories
    (nvim, tmux, zsh, alacritty, etc.)
```

### Key Components
- **GNU Stow** - Symlink farm manager that creates links from package directories to home directory
- **Package Directories** - Self-contained configuration bundles (nvim, tmux, zsh, etc.) that mirror home directory structure
- **install.sh** - Automated dependency installer for macOS using Homebrew
- **Custom Scripts (bin/)** - Utility scripts for system tasks (log4j checking, screen locking, etc.)
- **Configuration Files** - Application-specific settings (init.vim, .tmux.conf, .zshrc, etc.)

### Data Flow
1. User clones repository to `~/dotfiles`
2. User runs `install.sh` to install dependencies (Homebrew, Stow, applications)
3. User runs `stow <package>` to create symlinks from `~/dotfiles/<package>/` to `~/`
4. Applications read configuration from symlinked files in home directory
5. User edits files in `~/dotfiles/`, changes are immediately reflected (symlinks)
6. User commits and pushes changes to Git for version control

---

## 📁 Project Structure [Partial Directory Tree]

```
dotfiles/
├── alacritty/                  # Terminal emulator configuration
│   └── .config/
│       └── alacritty/
│           ├── alacritty.toml  # Main config (font, opacity, theme)
│           └── catppuccin/     # Catppuccin color theme
├── atom/                       # Atom editor (legacy)
├── bin/                        # Custom utility scripts
│   └── bin/
│       ├── check-log4j         # Log4j vulnerability checker
│       ├── lock-screen         # i3lock screen locker
│       ├── lock.sh             # Alternative lock script
│       ├── slack-cli           # Slack command-line tool
│       ├── software-centre     # Software management script
│       └── raycast/            # Raycast automation scripts
├── compton/                    # X11 compositor config (Linux)
├── dunst/                      # Notification daemon (Linux)
├── i3/                         # i3 tiling window manager (Linux)
│   └── .config/
├── i3status/                   # i3 status bar config
├── iterm2/                     # iTerm2 terminal (macOS)
├── lazyvim/                    # LazyVim configuration
│   └── .config/
├── nvim/                       # Neovim editor configuration
│   └── .config/
│       └── nvim/
│           ├── init.vim        # Main Neovim config
│           ├── autoload/       # vim-plug plugin manager
│           ├── lua/            # Lua configuration modules
│           │   └── mshirlaw/   # Custom Lua modules
│           ├── nvim-cmp/       # Completion configuration
│           ├── nvim-lspconfig/ # LSP configuration
│           ├── nvim-telescope/ # Fuzzy finder config
│           ├── nvim-tree/      # File tree config
│           └── ultisnips/      # Snippet definitions
├── ranger/                     # File manager configuration
├── rofi/                       # Application launcher (Linux)
├── skhd/                       # Hotkey daemon (macOS)
│   ├── .skhdrc                 # Keyboard shortcuts for yabai
│   └── .skhdrc.example         # Example configuration
├── spotify-tui/                # Spotify terminal UI
├── sublime-text/               # Sublime Text editor
├── tmux/                       # Terminal multiplexer
│   ├── .tmux.conf              # Main tmux configuration
│   ├── cheat-sheet.json        # Tmux command reference
│   └── plugins/
│       └── catppuccin/         # Catppuccin theme for tmux
├── vim/                        # Vim editor (legacy)
├── vscode/                     # Visual Studio Code
│   ├── keybindings.json        # Custom keybindings
│   ├── settings.json           # Editor settings
│   ├── snippets/               # Code snippets
│   └── tasks.json              # Build tasks
├── yabai/                      # Tiling window manager (macOS)
│   └── .config/
├── zsh/                        # Z shell configuration
│   └── .zshrc                  # Shell config with oh-my-zsh
├── .ackrc                      # ack search tool config
├── .gitignore                  # Git ignore patterns
├── .ignore                     # Global ignore patterns
├── README.md                   # Repository documentation
├── install.sh                  # Automated installer script
└── com.shirlaw.SyncS3.agent.plist  # LaunchAgent for S3 sync
```

---

### Key Files to Know

| File | Purpose | When You'd Touch It |
|------|---------|---------------------|
| `install.sh` | Automated dependency installer | Setting up new machine, adding new dependencies |
| `README.md` | Comprehensive setup documentation | Understanding how to use the repository |
| `nvim/.config/nvim/init.vim` | Neovim main configuration | Changing editor settings, adding plugins |
| `tmux/.tmux.conf` | Tmux configuration | Customizing terminal multiplexer behavior |
| `zsh/.zshrc` | Zsh shell configuration | Adding aliases, changing shell behavior |
| `alacritty/.config/alacritty/alacritty.toml` | Terminal emulator settings | Changing font, colors, opacity |
| `skhd/.skhdrc` | macOS keyboard shortcuts | Adding/modifying window management hotkeys |
| `nvim/.config/nvim/lua/mshirlaw/telescope.lua` | Custom Telescope functions | Adding custom fuzzy finder searches |
| `bin/bin/check-log4j` | Log4j vulnerability scanner | Checking projects for Log4Shell |
| `com.shirlaw.SyncS3.agent.plist` | S3 sync LaunchAgent | Configuring automated S3 backups |

---

## 🔧 Technology Stack

### Core Technologies
- **Shell:** Bash - Used for installation scripts and utilities
- **Configuration Language:** VimScript, Lua, TOML, JSON - Various config formats for different tools
- **Package Manager:** GNU Stow - Symlink farm manager for dotfiles deployment
- **Version Control:** Git - Configuration versioning and synchronization

### Key Libraries & Tools
- **vim-plug** - Neovim plugin manager for installing and managing editor extensions
- **oh-my-zsh** - Zsh framework for managing shell configuration and plugins
- **Catppuccin** - Color theme used across tmux, Alacritty, and other applications
- **Homebrew** - macOS package manager for installing dependencies
- **fzf** - Fuzzy finder for command-line and editor integration
- **ripgrep** - Fast search tool used with Neovim and shell

### Development Tools
- **Neovim** - Primary text editor with LSP, completion, and extensive plugin ecosystem
- **tmux** - Terminal multiplexer for managing multiple terminal sessions
- **Alacritty** - GPU-accelerated terminal emulator
- **yabai + skhd** - macOS tiling window manager and hotkey daemon
- **i3 + i3status** - Linux tiling window manager and status bar
- **Telescope** - Neovim fuzzy finder for files, buffers, and live grep

---

## 🌐 External Dependencies

### Required Services
- **Homebrew** - macOS package manager for installing all dependencies (critical for automated setup)
- **Git** - Required for cloning repository and version control
- **GNU Stow** - Essential for creating symlinks and deploying configurations

### Optional Integrations
- **AWS S3** - Used by `com.shirlaw.SyncS3.agent.plist` for automated document syncing (fallback: manual sync)
- **Wakatime** - Time tracking integration for Vim/Neovim (optional plugin)
- **NVM** - Node Version Manager for JavaScript development (loaded in .zshrc)
- **SDKMAN** - SDK manager for Java/Kotlin development (loaded in .zshrc)

---

### Environment Variables

```bash
# Shell Configuration
export ZSH="/$HOME/.oh-my-zsh"              # oh-my-zsh installation path
export EDITOR='nvim'                        # Default editor (nvim for local, vim for SSH)
export TERM=xterm-256color                  # Terminal color support

# Development Tools
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-case"  # fzf search command
export PATH=$HOME/.local/bin:$PATH          # Local binaries path

# Node.js
export NVM_DIR="$HOME/.nvm"                 # Node Version Manager directory

# Java/Kotlin
export SDKMAN_DIR="/$HOME/.sdkman"          # SDKMAN installation directory
```

---

## 🔄 Common Workflows

### Workflow 1: Setting Up a New Machine
1. Install Git and clone repository to `~/dotfiles`
2. Run `./install.sh` to install Homebrew, Stow, and all dependencies
3. Deploy configurations: `stow alacritty nvim tmux zsh`
4. Restart terminal or source shell: `source ~/.zshrc`
5. Open Neovim to auto-install plugins via vim-plug
6. Verify all symlinks are created correctly

**Code path:** `install.sh` → Homebrew → GNU Stow → Symlink creation → Application configuration loading

### Workflow 2: Adding a New Configuration Package
1. Create new directory in repository root (e.g., `mkdir -p myapp/.config/myapp`)
2. Add configuration files mirroring home directory structure
3. Test deployment: `stow -n myapp` (dry-run)
4. Deploy: `stow myapp`
5. Verify symlinks: `ls -la ~/.config/myapp`
6. Commit changes: `git add myapp && git commit -m "Add myapp configuration"`

**Code path:** New directory → `stow myapp` → Symlink creation → `~/.config/myapp/`

### Workflow 3: Updating Existing Configuration
1. Edit files directly in `~/dotfiles/<package>/` (changes are immediate via symlinks)
2. Test changes in the application
3. Commit changes: `cd ~/dotfiles && git add . && git commit -m "Update configuration"`
4. Push to remote: `git push`
5. On other machines: `git pull` (changes apply immediately via symlinks)

**Code path:** Edit in `~/dotfiles/` → Symlink reflects change → Application reads updated config → Git sync

---

## 📈 Performance & Scale

### Performance Considerations
- **Symlinks:** GNU Stow uses symlinks, so configuration changes are instantaneous (no copying)
- **Neovim startup:** Uses lazy-loading for plugins to minimize startup time
- **Shell startup:** oh-my-zsh plugins are kept minimal to avoid slow shell initialization
- **fzf integration:** Uses ripgrep for fast file searching with `FZF_DEFAULT_COMMAND`

### Monitoring
- **Metrics:** No formal monitoring; manual verification of symlinks and application behavior
- **Alerts:** None configured; errors surface during application startup or stow operations

---

## 🚨 Things to Be Careful About

### 🔒 Security Considerations
- **Sensitive data:** Never commit API keys, passwords, or tokens to this repository
- **SSH keys:** Not managed by this repository; keep separate and secure
- **S3 sync:** `com.shirlaw.SyncS3.agent.plist` contains AWS sync configuration; ensure credentials are managed via AWS CLI config
- **Public repository:** Assume all configuration is public; avoid personal information

### ⚠️ Common Pitfalls
- **Stow conflicts:** Existing files in home directory will cause stow to fail; backup or use `--adopt` to merge
- **Wrong directory:** Repository MUST be at `~/dotfiles` for configurations to work correctly (hardcoded paths in some configs)
- **Missing dependencies:** Some configurations require specific applications installed (e.g., Neovim for nvim config)
- **Platform differences:** Some packages are macOS-specific (yabai, skhd) or Linux-specific (i3, compton)
- **oh-my-zsh installation:** Must be installed before stowing zsh config, or .zshrc will fail to load

### 🔧 Maintenance Notes
- **Plugin updates:** Neovim plugins managed by vim-plug; run `:PlugUpdate` in Neovim
- **Theme updates:** Catppuccin themes are vendored in `tmux/plugins/` and `alacritty/.config/alacritty/`
- **Stow re-deployment:** After adding new files to a package, run `stow -R <package>` to update symlinks
- **Backup before changes:** Use `stow -n` to preview changes before applying

---

*Update to last commit: 9c8c9b1568129f147da68eb7aeb31a26a312fe24*
*Last updated: 2025-11-24*
