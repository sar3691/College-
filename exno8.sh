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

# Create a temporary file with the list of valid files
VALID_FILES=$(mktemp)

# Read file list line-by-line and check for existence
while IFS= read -r FILE_NAME; do
    # Remove potential Windows carriage returns
    CLEAN_FILE_NAME=$(echo "$FILE_NAME" | tr -d '\r')

    # !! BUG FIX: Skip empty lines !!
    if [ -z "$CLEAN_FILE_NAME" ]; then
        continue
    fi

    if [ -e "$CLEAN_FILE_NAME" ]; then # Use -e to check for existence (file or directory)
        echo "$CLEAN_FILE_NAME" >> "$VALID_FILES"
    else
        echo "Warning: $CLEAN_FILE_NAME doesn't exist. Skipping..."
    fi
done < "$SOURCE"

if [ ! -s "$VALID_FILES" ]; then
    echo "No valid files to back up. Exiting."
    rm "$VALID_FILES"
    exit 1
fi

echo "Starting Archive..."
# Use the --files-from option to read the list of files
tar -czf "$DESTINATION" --files-from="$VALID_FILES" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Archive COMPLETED at: $DESTINATION"
else
    echo "Failed to create archive."
fi

# Clean up the temporary file
rm "$VALID_FILES"
