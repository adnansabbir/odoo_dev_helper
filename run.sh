#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
UPDATE_CHECK_SCRIPT="$SCRIPT_DIR/update_check.sh"
OPERATION_NAME=$1
shift

help() {
  echo -e "\nAvailable operations:\n"
  printf "\e[1m%-25s\e[0m : %s\n" "help | -h" "Shows the available operations"

  printf "\e[1m%-25s\e[0m : %s\n" "create_module | cm" "Create a new Odoo module"
  printf "  %-25s - %s\n" "" "params: --name=module_name#version(int)"

  printf "\e[1m%-25s\e[0m : %s\n" "setup_db | sd" "Create/replace with new DB, import dump, run cleanup"
  printf "  %-25s - %s\n" "" "params: --d=database_name"

  printf "\e[1m%-25s\e[0m : %s\n" "update | up" "Checks for updates and updates odh if available"

  printf "\e[1m%-25s\e[0m : %s\n" "remove | rm" "Uninstalls the Odoo Development Helper(odh)"
  echo -e "\n"
}


case $OPERATION_NAME in
  help | -h)
    help
    ;;
  create_module | cm)
    SCRIPT_PARAMS=$@
    bash "$SCRIPT_DIR/create_module/create_module.sh" "$SCRIPT_PARAMS"
    ;;
  setup_db | sd)
    SCRIPT_PARAMS=$@
    bash "$SCRIPT_DIR/setup_db/setup_db.sh" "$SCRIPT_PARAMS"
    ;;
  remove | rm)
    bash "$SCRIPT_DIR/uninstall.sh"
    ;;
  update | up)
    bash "$UPDATE_CHECK_SCRIPT" "-u"
    ;;
  *)
    help
    ;;
esac

#Check for update
bash "$UPDATE_CHECK_SCRIPT"
exit 1
