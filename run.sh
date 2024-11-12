#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
OPERATION_NAME=$1
shift

if [ -z "$OPERATION_NAME" ]; then
  echo "Please specify operation name, example: odh create_module or odh cm"
  exit 1
fi

case $OPERATION_NAME in
  create_module | cm)
    SCRIPT_PARAMS=$@
#    echo "Creating module with params $SCRIPT_PARAMS"
    bash "$SCRIPT_DIR/create_module.sh" "$SCRIPT_PARAMS"
    ;;
  *)
    echo "Operation $OPERATION_NAME not found"
    exit 1
    ;;
esac
