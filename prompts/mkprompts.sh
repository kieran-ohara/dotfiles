#!/bin/bash
# Set the folder path
folder=$1
# Create the CSV file
csv_file=$2
echo "\"act\",\"prompt\"" > "$csv_file"
# Iterate through the folder
for file in "$folder/"*.txt; do
    # Extract the file name (minus the extension) as "act"
    act=$(basename "$file" .txt)
    # Read the file contents and remove all line endings
    prompt=$(tr -d '\r\n' < "$file")
    # Escape quotes in the file contents
    prompt="${prompt//\"/\\\"}"
    # Append the row to the CSV file
    echo "\"$act\",\"$prompt\"" >> "$csv_file"
done
echo "CSV file created: $csv_file"

