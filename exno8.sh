#!/bin/bash

DATE=$(date +%y%m%d)

read -p "Give name to the archive file: " file
FILE="${file}${DATE}.tgz"

read -p "Enter the name of the file containing list of files to back up: " SOURCE
read -p "Enter the destination path for the archive: " des

DESTINATION="${des}/${FILE}"

# Check if the source file exists
if [ ! -f "$SOURCE" ]; then
    echo "Error: $SOURCE doesn't exist. BACKUP INCOMPLETE."
    exit 1
fi

FILE_LIST=""

# Read file list line-by-line
while IFS= read -r FILE_NAME; do
    if [ -f "$FILE_NAME" ] || [ -d "$FILE_NAME" ]; then
        FILE_LIST="$FILE_LIST \"$FILE_NAME\""
    else
        echo "Warning: $FILE_NAME doesn't exist. Skipping..."
    fi
done < "$SOURCE"

if [ -z "$FILE_LIST" ]; then
    echo "No valid files to back up. Exiting."
    exit 1
fi

echo "Starting Archive..."
# Use `eval` to properly interpret quotes around file names
eval tar -czf "\"$DESTINATION\"" $FILE_LIST 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Archive COMPLETED at: $DESTINATION"
else
    echo "Failed to create archive."
fi
