#!/bin/bash

ODH_DIR="/usr/local/odh"
SHELL_CONFIG="$HOME/.bashrc"
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

# Remove the alias
sed -i '/alias odh=/d' "$SHELL_CONFIG"
echo "Alias 'odh' removed from $SHELL_CONFIG"

# Remove the installation directory
if [[ -d "$ODH_DIR" ]]; then
    echo "Removing installation directory at $ODH_DIR..."
    sudo rm -rf "$ODH_DIR"
fi

echo "Uninstallation complete. The 'odh' command has been removed."
