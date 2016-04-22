#!/bin/sh
CONFIG_PATH=/root/bin/shell/mailvalidator.conf
INPUT_DIR=$(awk -F "=" '/^input_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
BUF_DIR=$(awk -F "=" '/^buf_dir/{print $2}' $CONFIG_PATH | tr -d ' ')
LINES_NUM=$(awk -F "=" '/^lines_num/{print $2}' $CONFIG_PATH | tr -d ' ')
find $INPUT_DIR -type f -name "*.clear" -exec basename {} \; | xargs -I {} split -d -a 3 -l $LINES_NUM "$INPUT_DIR/{}" "$BUF_DIR/{}"
find $INPUT_DIR -type f -name "*.clear" -exec rm {} \;
