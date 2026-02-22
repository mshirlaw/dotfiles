# Dotfiles

Custom settings for various editors and new machine setup using GNU Stow.

## Overview

This repository contains configuration files (dotfiles) for various applications and tools. It uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks, making it easy to deploy configurations on new machines.

## Available Configurations

This repository currently provides configuration for:

* **alacritty** - Terminal emulator
* **atom** - Text editor
* **bin** - Custom scripts
* **compton** - Compositor for X11
* **dunst** - Notification daemon
* **i3** - Tiling window manager
* **i3status** - Status bar for i3
* **iterm2** - macOS terminal emulator
* **lazyvim** - LazyVim configuration
* **nvim** - Neovim editor
* **opencode** - OpenCode CLI configuration
* **ranger** - File manager
* **rofi** - Application launcher
* **skhd** - Hotkey daemon for macOS
* **spotify-tui** - Spotify terminal UI
* **sublime-text** - Text editor
* **tmux** - Terminal multiplexer
* **vim** - Vim editor
* **vscode** - Visual Studio Code
* **yabai** - Tiling window manager for macOS
* **zsh** - Z shell

## Prerequisites

### Required Software

* **Git** - To clone this repository
* **GNU Stow** - To manage symlinks
* **Homebrew** (macOS) - Package manager

### Optional Software (depending on which configs you want to use)

* vim
* neovim
* ripgrep
* fzf
* tmux
* oh-my-zsh
* alacritty

## Setup Instructions

### 1. Clone the Repository

Clone this repository to your home directory:

```bash
cd ~
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
```

**Important:** The dotfiles repository should be cloned to `~/dotfiles` for the configurations to work correctly.

### 2. Install Dependencies (macOS)

You can use the provided `install.sh` script to automatically install all dependencies:

```bash
chmod +x install.sh
./install.sh
```

Or install dependencies manually:

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install GNU Stow
brew install stow

# Install oh-my-zsh (optional, for zsh configuration)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install other tools as needed
brew install neovim
brew install ripgrep
brew install fzf
brew install tmux
brew install --cask alacritty
```

### 3. Deploy Configurations with Stow

GNU Stow creates symlinks from this repository to your home directory. Each subdirectory in this repo is a "stow package" that can be deployed independently.

#### Deploy Individual Packages

To deploy a specific configuration:

```bash
cd ~/dotfiles
stow <package-name>
```

For example:
```bash
stow nvim      # Deploy Neovim configuration
stow tmux      # Deploy tmux configuration
stow zsh       # Deploy zsh configuration
stow alacritty # Deploy Alacritty configuration
```

#### Deploy Multiple Packages at Once

```bash
stow alacritty nvim tmux zsh
```

#### Deploy All Packages

```bash
stow */
```

**Note:** Only stow packages for applications you actually have installed.

### 4. Verify Installation

Check that symlinks were created correctly:

```bash
ls -la ~ | grep "\->"
```

You should see symlinks pointing to files in `~/dotfiles/`.

For example:
```
.zshrc -> dotfiles/zsh/.zshrc
.tmux.conf -> dotfiles/tmux/.tmux.conf
```

## How GNU Stow Works

GNU Stow creates symlinks from the stow directory (this repo) to the parent directory (your home directory).

### Directory Structure

Each package in this repository mirrors the structure it should have in your home directory:

```
dotfiles/
├── nvim/
│   └── .config/
│       └── nvim/
│           └── init.vim
├── tmux/
│   └── .tmux.conf
└── zsh/
    └── .zshrc
```

When you run `stow nvim`, it creates:
```
~/.config/nvim/init.vim -> ~/dotfiles/nvim/.config/nvim/init.vim
```

When you run `stow tmux`, it creates:
```
~/.tmux.conf -> ~/dotfiles/tmux/.tmux.conf
```

## Managing Configurations

### Adding New Configurations

1. Create a new directory for the package
2. Mirror the directory structure as it should appear in your home directory
3. Add your configuration files
4. Run `stow <package-name>` to deploy

### Removing Configurations

To remove a stowed package (delete the symlinks):

```bash
cd ~/dotfiles
stow -D <package-name>
```

For example:
```bash
stow -D nvim  # Remove Neovim symlinks
```

### Updating Configurations

Since stow creates symlinks, any changes you make to files in `~/dotfiles/` are immediately reflected in your home directory. Just commit and push your changes:

```bash
cd ~/dotfiles
git add .
git commit -m "Update configuration"
git push
```

### Re-stowing (Updating Symlinks)

If you add new files to a package, re-stow it:

```bash
stow -R <package-name>
```

## Troubleshooting

### Conflicts

If stow reports conflicts (files already exist), you have two options:

1. **Backup and remove existing files:**
   ```bash
   mv ~/.zshrc ~/.zshrc.backup
   stow zsh
   ```

2. **Adopt existing files into the repo:**
   ```bash
   stow --adopt zsh
   ```
   This moves the existing file into the dotfiles repo and creates the symlink.

### Checking What Would Happen

Use the `-n` (dry-run) flag to see what stow would do without actually doing it:

```bash
stow -n nvim
```

### Verbose Output

Use the `-v` flag for detailed output:

```bash
stow -v nvim
```

## Setting Up a New Machine

1. Install Git and clone this repository to `~/dotfiles`
2. Run `./install.sh` to install all dependencies (macOS)
3. Stow the packages you need: `stow alacritty nvim tmux zsh`
4. Restart your terminal or source your shell config: `source ~/.zshrc`

## Additional Files

* `.ackrc` - Configuration for ack search tool
* `.ignore` - Global ignore patterns
* `com.shirlaw.SyncS3.agent.plist` - LaunchAgent configuration

## License

Feel free to use and modify these configurations for your own use.
