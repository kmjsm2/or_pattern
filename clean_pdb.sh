#!/bin/bash

# Directories
input_dir="/Users/zoekim/Desktop/l3/aroma_sub/Woody"
output_dir="/Users/zoekim/Desktop/l3/aroma_sub_clean/woody"

# Ensure output directory exists
mkdir -p "$output_dir"

# Check if the input directory exists
if [[ ! -d "$input_dir" ]]; then
  echo "Error: Input directory $input_dir does not exist."
  exit 1
fi

# List the contents of the input directory for verification
echo "Listing contents of the input directory:"
ls -l "$input_dir"

# Set environment variables for PyMOL script
export pdb_dir="$input_dir"
export output_dir="$output_dir"

# Run the PyMOL script
pymol -cq clean_pdb.py

echo "PDB cleaning process complete."
