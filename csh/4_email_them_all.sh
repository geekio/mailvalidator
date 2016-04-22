#!/bin/sh
CONFIG_PATH=/root/bin/shell/mailvalidator.conf
BUF_DIR=$(awk -F "=" '/^buf_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
OUTPUT_DIR=$(awk -F "=" '/^output_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
COMPLETED_DIR=$(awk -F "=" '/^completed_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
# main loop fetching all the files waiting to be completed 
for entry in $(find $COMPLETED_DIR -type f -exec basename {} \; | egrep -v '*.completed$')
do
  # if any file is being locked than break 
  if [ $(find $OUTPUT_DIR -type f -empty -name "$entry*" | wc -l) -ge "1" ]; then
       continue 
  else
  # concatenating  
  find $OUTPUT_DIR -type f -name "$entry*" -exec cat {} + > "$COMPLETED_DIR/$entry.completed" 
  # emailing
  # mailsend 
  # cleaning buffer  
  find $BUF_DIR -type f -name "$entry*" -exec rm {} +
  # cleaning output
  find $OUTPUT_DIR -type f -name "$entry*" -exec rm {} +
  # removing checkpoint
  rm "$COMPLETED_DIR/$entry"
  fi 
done
