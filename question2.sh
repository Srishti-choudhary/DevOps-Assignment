#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_directory>"
    exit 1
fi

DIR=$1

# Check if the directory exists and is readable
if [ ! -d "$DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Initialize an associative array to store file type counts
declare -A file_types

# Traverse the directory recursively and count file types
while IFS= read -r -d '' file; do
    extension="${file##*.}"
    if [ "$extension" != "$file" ]; then
        ((file_types["$extension"]++))
    else
        ((file_types["no_extension"]++))
    fi
done < <(find "$DIR" -type f -print0)

# Output the sorted list of file types along with their counts
echo "File Type Counts:"
for extension in "${!file_types[@]}"; do
    echo "$extension: ${file_types[$extension]}"
done | sort
