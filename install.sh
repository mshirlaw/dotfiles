#!/bin/bash

set -e  # Exit on error

echo "======================================"
echo "Dotfiles Installation Script"
echo "======================================"
echo

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Homebrew on macOS
if ! command_exists brew; then
    echo "INFO: Installing Homebrew"
    echo
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "INFO: Homebrew already installed"
    echo
fi

# Update Homebrew
echo "INFO: Updating Homebrew"
echo
brew update

# Install GNU Stow (needed for dotfiles management)
if ! command_exists stow; then
    echo "INFO: Installing GNU Stow"
    echo
    brew install stow
else
    echo "INFO: GNU Stow already installed"
    echo
fi

# Install Alacritty
if ! brew list --cask alacritty &>/dev/null; then
    echo "INFO: Installing Alacritty"
    echo
    brew install --cask alacritty
else
    echo "INFO: Alacritty already installed"
    echo
fi

# Install Neovim
if ! command_exists nvim; then
    echo "INFO: Installing Neovim"
    echo
    brew install neovim
else
    echo "INFO: Neovim already installed"
    echo
fi

# Install ripgrep
if ! command_exists rg; then
    echo "INFO: Installing ripgrep"
    echo
    brew install ripgrep
else
    echo "INFO: ripgrep already installed"
    echo
fi

# Install fzf
if ! command_exists fzf; then
    echo "INFO: Installing fzf"
    echo
    brew install fzf
    
    # Install fzf shell integration
    echo "INFO: Installing fzf shell integration"
    "$(brew --prefix)"/opt/fzf/install --all --no-bash --no-fish
else
    echo "INFO: fzf already installed"
    echo
fi

# Install tmux
if ! command_exists tmux; then
    echo "INFO: Installing tmux"
    echo
    brew install tmux
else
    echo "INFO: tmux already installed"
    echo
fi

# Change into dotfiles directory
echo "INFO: Changing to dotfiles directory"
echo
cd "$HOME/dotfiles" || {
    echo "ERROR: Could not find $HOME/dotfiles directory"
    echo "Please clone the dotfiles repository to $HOME/dotfiles first"
    exit 1
}

# Stow configurations
echo "INFO: Setting up configuration directories"
echo

STOW_PACKAGES=("alacritty" "nvim" "tmux" "zsh")

for package in "${STOW_PACKAGES[@]}"; do
    if [[ -d "$package" ]]; then
        echo "Stowing $package..."
        stow -v "$package" || {
            echo "WARNING: Failed to stow $package (may already exist)"
        }
    else
        echo "WARNING: Package $package not found, skipping"
    fi
done

echo
echo "======================================"
echo "Core installation complete!"
echo "======================================"
echo

# Install oh-my-zsh last (as it's interactive and changes shell)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "INFO: Installing oh-my-zsh"
    echo "NOTE: This will start a new shell. You may need to exit and restart."
    echo
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "INFO: oh-my-zsh already installed"
    echo
fi

echo
echo "======================================"
echo "Installation Complete!"
echo "======================================"
echo
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Check that configurations are working correctly"
echo "3. Customize settings as needed in ~/dotfiles/"
echo
