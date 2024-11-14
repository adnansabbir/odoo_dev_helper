#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
GITHUB_REPO="https://github.com/adnansabbir/odoo_dev_helper.git"

#Get the version number and date from the file
VERSION_INFO=$(cat "${SCRIPT_DIR}/version_info.txt")
VERSION_NUMBER=$(echo "$VERSION_INFO" | head -n 1)

#Get the latest version on repo
LATEST_VERSION=$(curl -s "$GITHUB_REPO/blob/main/.version_info" | head -n 1)

#Check if the latest version is different from the current version
if [[ "$LATEST_VERSION" != "$VERSION_NUMBER" ]]; then
  if [[ "$1" == "-u" ]]; then
    echo "Updating the script..."
    cd "$SCRIPT_DIR" || exit 1
    #need to work here for proper update
    echo "Update complete. Please restart your terminal."
    exit 0
  fi

  echo "A new version of the script is available. Please update the script."
  echo "Current version: $VERSION_NUMBER"
  echo "Latest version: $LATEST_VERSION"
  echo "Run sudo odh update/up to update the script"
  exit 1
fi
