#!/bin/sh
CONFIG_PATH=/root/bin/shell/mailvalidator.conf
BUF_DIR=$(awk -F "=" '/^buf_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
OUTPUT_DIR=$(awk -F "=" '/^output_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
MAILVALIDATOR_PATH=$(awk -F "=" '/^mailvalidator_path/{print $2}' $CONFIG_PATH | tr -d ' ')
BLACKLIST_PATH=$(awk -F "=" '/^blacklist_path/{print $2}' $CONFIG_PATH | tr -d ' ')
PROC_MAX_N=$(awk -F "=" '/^proc_max_n/{print $2}' $CONFIG_PATH | tr -d ' ')
# main loop fetching all the files in a buf directory
for entry in "$BUF_DIR"/*
do
  # check if we overrun PROC_MAX_N
  PROC_N=$( ps auxwww | grep $MAILVALIDATOR_PATH | wc -l | awk '{print $1}' )
  if [ "$PROC_N" -ge "$PROC_MAX_N" ]; then
        break
  fi
  # check if the file is already in processing
  FILENAME=$(basename $entry)
  if [ -f "$OUTPUT_DIR/$FILENAME.output" ]; then
        continue
  else
        $MAILVALIDATOR_PATH -l -t 10 -mx 2 -xlist $BLACKLIST_PATH -flist $entry > $OUTPUT_DIR/$FILENAME.output &
  fi
done
