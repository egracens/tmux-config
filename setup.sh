#!/bin/bash

# ==============================================================================
# TMUX CONFIGURATION SETUP SCRIPT
# ==============================================================================
# This script installs all dependencies required for the tmux configuration
# Tested on: Debian/Ubuntu (including WSL)
# ==============================================================================

set -e

echo "=== Tmux Configuration Setup ==="
echo ""

# Check if running on Debian/Ubuntu
if ! command -v apt &> /dev/null; then
    echo "Error: This script requires apt (Debian/Ubuntu)"
    exit 1
fi

echo "Installing dependencies..."

# Update package list
sudo apt update

# ------------------------------------------------------------------------------
# CORE DEPENDENCIES
# ------------------------------------------------------------------------------

# tmux - terminal multiplexer
sudo apt install -y tmux

# ncurses-term - provides tmux-256color terminfo for true color support
sudo apt install -y ncurses-term

# git - required for cloning TPM and plugins
sudo apt install -y git

# ------------------------------------------------------------------------------
# SYMLINK CONFIG
# ------------------------------------------------------------------------------

# Create symlink for compatibility with older tmux versions
ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf
echo "Created symlink: ~/.tmux.conf -> ~/.config/tmux/tmux.conf"

# ------------------------------------------------------------------------------
# TPM (TMUX PLUGIN MANAGER)
# ------------------------------------------------------------------------------

TPM_DIR="$HOME/.config/tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
    echo "TPM already installed, updating..."
    git -C "$TPM_DIR" pull
else
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# ------------------------------------------------------------------------------
# VERIFICATION
# ------------------------------------------------------------------------------

echo ""
echo "=== Verifying installation ==="

# Check tmux
if command -v tmux &> /dev/null; then
    echo "[OK] tmux $(tmux -V)"
else
    echo "[FAIL] tmux not found"
    exit 1
fi

# Check terminfo
if infocmp tmux-256color &> /dev/null; then
    echo "[OK] tmux-256color terminfo"
else
    echo "[FAIL] tmux-256color terminfo not found"
    exit 1
fi

# Check TPM
if [ -d "$TPM_DIR" ]; then
    echo "[OK] TPM installed"
else
    echo "[FAIL] TPM not found"
    exit 1
fi

# ------------------------------------------------------------------------------
# INSTALL TMUX PLUGINS
# ------------------------------------------------------------------------------

echo ""
echo "=== Installing tmux plugins ==="

# Run TPM plugin install script (installs plugins defined in tmux.conf)
"$TPM_DIR/bin/install_plugins"

echo "[OK] Plugins installed"

echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: tmux kill-server"
echo "  2. Start tmux: tmux"
echo ""
