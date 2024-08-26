: '
This script downloads provided Fastq sample files.
'

#!/bin/bash

# Usage: ./samples_fastq.sh <file1> <file2> ...

for file in "$@"; do
    # Check if file exists
    if [ ! -f "$file" ]; then
        echo "File $file does not exist. Skipping..."
        continue
    fi

    echo "Loading data for $file"
    mapfile -t FASTQ_FILES <"$file"

    for FASTQ_FILE in "${FASTQ_FILES[@]}"; do
        echo "FASTQ_FILE: $FASTQ_FILE"

        # Extract just the file name from the URL
        file_name=$(basename "$FASTQ_FILE")

        # Check if destination file already exists
        dest_dir="/fileserver_data"
        dest_file="$dest_dir/$file_name"
        if [ -f "$dest_file" ]; then
            echo "Destination file $dest_file already exists. Skipping..."
            continue
        fi

        echo "Downloading $FASTQ_FILE to $dest_dir..."
        mkdir -p "$dest_dir"
        # Check for already downloaded file
        if ls "$dest_dir/$file_name"* 1> /dev/null 2>&1; then
            echo "$file_name already downloaded. Skipping download..."
            continue
        fi
        # Get the file
        curl -o "$dest_file" "$FASTQ_FILE"
        if [ -f "$dest_file" ]; then
            echo "Unzipping $dest_file..."
            gzip -d "$dest_file"
        fi
    done
done

echo "Sample loading complete..."
