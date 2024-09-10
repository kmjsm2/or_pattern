#!/bin/bash

# Directories
RECEPTOR_DIR="/Users/zoekim/Desktop/l3/vina_OR/trimmed_pdbqt"
PDBQT_DIR="/Users/zoekim/Desktop/l3/aroma_result/pdbqt/Naringin"
NEW_PDBQT_DIR="/Users/zoekim/Desktop/l3/aroma_result/pdbqt/Naringin_remain"

# Create new directory if it doesn't exist
mkdir -p "$NEW_PDBQT_DIR"

# Copy PDBQT files that are not included in the result directory
for receptor_pdbqt_file in "$RECEPTOR_DIR"/*.pdbqt; do
  base_name=$(basename "$receptor_pdbqt_file" .pdbqt)

  # Check if the basename is included in any file in the result directory
  if ! ls "$PDBQT_DIR/${base_name}"* 1> /dev/null 2>&1; then
    cp "$receptor_pdbqt_file" "$NEW_PDBQT_DIR/"
  fi
done
