#!/bin/bash

CURR_DIR=$(pwd)
SCRIPT_DIR=$(dirname "$(realpath "$0")")

CLEAN_DB_SCRIPT="${SCRIPT_DIR}/clean_db_script.sql"

DATABASE_NAME=''

#Check if any argument with flag -d is provided
while [[ "$1" != "" ]]; do
    case $1 in
    --n=*)
        DATABASE_NAME="${1#*=}"
        shift
        ;;
    *)
      shift
      ;;
    esac
done

#check if database name is provided
if [ -z "$DATABASE_NAME" ]; then
  echo "Please provide database name with flag --n=database_name"
  exit 1
fi

#check if file with name dump.sql present in the current directory
if [ ! -f "${CURR_DIR}/dump.sql" ]; then
  echo "dump.sql file not found in the current directory"
  exit 1
fi

#drop the database if exists
echo "Dropping database $DATABASE_NAME if exists"
dropdb --if-exists "$DATABASE_NAME"

#create the database
echo "Creating database $DATABASE_NAME"
createdb "$DATABASE_NAME"

#restore the dump file
echo "Restoring dump file"
psql "$DATABASE_NAME" < "${CURR_DIR}/dump.sql"

#run the cleanup script
echo "Running cleanup script"
psql "$DATABASE_NAME" < "$CLEAN_DB_SCRIPT"

echo "Database setup completed"
