#!/bin/bash

DIR=$(pwd)
SCRIPT_DIR=$(dirname "$(realpath "$0")")

MANIFEST_TEMPLATE="${SCRIPT_DIR}/__manifest__.py"

MODULE_NAME=''
MODULE_VERSION='17'

#Check if any argument with flag -n is provided
while [[ "$1" != "" ]]; do
    case $1 in
    --name=*)
        # Extract the full name with version
        FULL_NAME="${1#*=}"

        # Separate MODULE_NAME and MODULE_VERSION based on the presence of #
        if [[ "$FULL_NAME" == *"#"* ]]; then
            MODULE_NAME="${FULL_NAME%#*}"      # Text before #
            MODULE_VERSION="${FULL_NAME#*#}"   # Text after #
        else
            MODULE_NAME="$FULL_NAME"
        fi

        shift
        ;;
    *)
      shift
      ;;
    esac
done

echo "Module name: $MODULE_NAME, Module version: $MODULE_VERSION"

if [ -z "$MODULE_NAME" ]; then
  echo "Please provide module name with flag --name=module_name#17"
  exit 1
fi

# Function to format module name
format_module_name() {
  local raw_name="$1"
  # Split by underscores, capitalize each word, and join with spaces
  echo "$raw_name" | awk -F '_' '{for (i=1; i<=NF; i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1' OFS=" "
}

create_base_module(){
  echo "Creating module $MODULE_NAME"
  local module_path="${DIR}/${MODULE_NAME}"
  mkdir -p $module_path

  # Create __init__.py file
  touch $module_path/__init__.py

  # Create __manifest__.py file
  # Format the module name for display in the manifest
  FORMATTED_MODULE_NAME=$(format_module_name "$MODULE_NAME")
  echo $FORMATTED_MODULE_NAME
  # Copy the manifest template
  if [[ -f "$MANIFEST_TEMPLATE" ]]; then
    # Replace placeholders in the manifest template
    sed -e "s/\[NAME\]/$FORMATTED_MODULE_NAME/g" \
        -e "s/\[SUMMARY\]/$FORMATTED_MODULE_NAME/g" \
        -e "s/\[CATEGORY\]/$MODULE_NAME/g" \
        -e "s/\[VERSION\]/$MODULE_VERSION/g" \
        "$MANIFEST_TEMPLATE" > "${module_path}/__manifest__.py"
  else
      echo "Manifest template not found. Creating a default manifest file."
      echo "# __manifest__.py for $MODULE_NAME" > "${module_path}/__manifest__.py"
  fi
}

create_base_module

#Create models, views and others in the module
