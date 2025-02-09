#!/bin/bash
 
# Check if command-line arguments are passed
if [ "$#" -gt 0 ]; then
    # If directories are provided, delete .swp files only from those directories
    for dir in "$@"; do
        if [ -d "$dir" ]; then
            # Find and delete .swp files in the specified directory
            find "$dir" -name '*.swp' -delete
        else
            echo "$dir is not a valid directory."
        fi
    done
else
    # If no arguments are provided, delete .swp files from the ~/ directory
    find ~/ -name '*.swp' -delete
fi
 
# Check if any .swp files were found and deleted
if [ "$(find ~/ -name '*.swp' | wc -l)" -eq 0 ]; then
    echo "No .swp files found."
else
    echo "Deleted all .swp files."
fi
