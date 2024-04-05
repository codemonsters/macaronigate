#!/bin/bash

# Check if correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_image.png> <output_directory>"
    exit 1
fi

input_image="$1"
output_dir="$2"

# Check if input image exists
if [ ! -f "$input_image" ]; then
    echo "Input image '$input_image' not found."
    exit 1
fi

# Check if output directory exists, if not create it
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# Define sizes for scaled-down versions
sizes=(40 58 60 76 80 87 120 152 160 192 432 512 1024)

# Loop through each size and create scaled-down versions
for size in "${sizes[@]}"; do
    output_file="$output_dir/$(basename "$input_image" .png)-${size}px.png"
    convert "$input_image" -resize "${size}x${size}^" "$output_file"
    echo "Created $output_file"
done

echo "Batch resizing completed."