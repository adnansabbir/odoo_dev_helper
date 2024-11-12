#!/bin/bash

# Define the install directory
INSTALL_DIR="/usr/local/odh"

# Remove the existing install directory if it exists (for updates)
if [[ -d "$INSTALL_DIR" ]]; then
    echo "Removing existing installation at $INSTALL_DIR..."
    sudo rm -rf "$INSTALL_DIR"
fi

# Ensure the install directory exists, then copy everything
sudo mkdir -p "$INSTALL_DIR"
sudo cp -r ./* "$INSTALL_DIR/"  # Copy everything in the current directory to the install directory

# Determine which shell configuration file to use
SHELL_CONFIG="$HOME/.bashrc"
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

# Remove any existing 'odh' alias to avoid conflicts
sed -i '/alias odh=/d' "$SHELL_CONFIG"

# Add new alias to .bashrc or .zshrc
echo "alias odh='bash $INSTALL_DIR/run.sh'" >> "$SHELL_CONFIG"
echo "Alias 'odh' added to $SHELL_CONFIG"

# Reload shell configuration to make the alias immediately available
source "$SHELL_CONFIG"

echo "Installation complete. You can now use 'odh' as a global command."
