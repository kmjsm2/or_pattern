#!/bin/bash

# Directories
NEW_PDB_DIR="/Users/zoekim/Desktop/l3/vina_OR/new_cleaned_ligand"
TRIMMED_DIR="/Users/zoekim/Desktop/l3/vina_OR/new_trimmed_ligand_pdb"
PDBQT_DIR="/Users/zoekim/Desktop/l3/vina_OR/new_trimmed_ligand_pdbqt"
LOG_DIR="/Users/zoekim/Desktop/l3/vina_OR/new_ligand_logs"

# Create directories if they don't exist
mkdir -p "$TRIMMED_DIR"
mkdir -p "$PDBQT_DIR"
mkdir -p "$LOG_DIR"

# ChimeraX executable path
chimera_path="/Applications/ChimeraX-1.8.app/Contents/MacOS/ChimeraX"  # Update this path as needed

# Loop through all PDB files in the new directory
for pdb_file in "$NEW_PDB_DIR"/*.pdb; do
  base_name=$(basename "$pdb_file" .pdb)
  trimmed_pdb_file="$TRIMMED_DIR/${base_name}_trimmed.pdb"
  pdbqt_file="$PDBQT_DIR/${base_name}.pdbqt"
  log_file="$LOG_DIR/${base_name}_chimera.log"
  obabel_log_file="${log_file%.log}_obabel.log"

  # Run ChimeraX to trim the PDB file and log output
  $chimera_path --nogui --cmd "open $pdb_file; delete solvent; delete ions; delete ligand; save $trimmed_pdb_file; close all; exit" > "$log_file" 2>&1

  # Check if the trimmed PDB file was created successfully
  if [[ -s "$trimmed_pdb_file" ]]; then
    # Convert the trimmed PDB file to PDBQT format using OpenBabel and log output
    obabel "$trimmed_pdb_file" -O "$pdbqt_file" -xr -p 7.4 --partialcharge eem > "$obabel_log_file" 2>&1
  else
    echo "Error: $trimmed_pdb_file was not created or is empty." | tee -a "$log_file"
  fi
done
