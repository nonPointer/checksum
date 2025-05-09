#!/bin/bash

# Create temp file for current checksums
temp_file=$(mktemp)

# Generate '"filename" md5hash' for all regular files
# excluding checksum.txt itself and hidden files
find . -maxdepth 1 -type f ! -name "checksum.txt" ! -name ".*" -print0 |
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    hash=$(md5sum "$file" | awk '{print $1}')
    echo "\"$filename\" $hash"
done | sort > "$temp_file"

# Compare with existing checksum.txt if it exists
if [ -f checksum.txt ]; then
    echo "Differences between current checksums and checksum.txt:"
    diff -u <(sort checksum.txt) "$temp_file"
else
    echo "checksum.txt does not exist. Here's the current list of checksums:"
    cat "$temp_file"
fi

# Ask user if they want to update checksum.txt
read -p "Do you want to update checksum.txt with current values? [y/N] " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    mv "$temp_file" checksum.txt
    echo "checksum.txt has been updated."
else
    echo "checksum.txt was not updated."
    rm "$temp_file"
fi