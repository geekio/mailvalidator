#!/bin/sh
CONFIG_PATH=/root/bin/robo/mailvalidator.conf
INPUT_DIR=$(awk -F "=" '/^input_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
COMPLETED_DIR=$(awk -F "=" '/^completed_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
# main loop fetching all except already cleared files in a directory

FILENAME=$(basename $1)
grep -EiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" "$1" | sort | uniq | tr '[:upper:]' '[:lower:]' > "$INPUT_DIR/$FILENAME.clear" 
touch "$COMPLETED_DIR/$FILENAME"
wc -l "$INPUT_DIR/$FILENAME.clear" | awk '{print $1}'
