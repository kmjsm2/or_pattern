#!/bin/bash

# Path to the single PDB file
PDB_FILE="/Users/zoekim/Desktop/test_recep_confirm/OR13C5.pdb"
# Directory to save trimmed PDB files
TRIMMED_DIR="/Users/zoekim/Desktop/test_recep_confirm_trim"
# Directory to save PDBQT files
PDBQT_DIR="/Users/zoekim/Desktop/test_recep_confirm_pdbqt"
# Log directory
LOG_DIR="/Users/zoekim/Desktop/test_recep_confirm_log"

# Create directories if they don't exist
mkdir -p "$TRIMMED_DIR"
mkdir -p "$PDBQT_DIR"
mkdir -p "$LOG_DIR"

# ChimeraX executable path
chimera_path="/Applications/ChimeraX-1.8.app/Contents/MacOS/ChimeraX"  # Update this path as needed

# Get the base name of the file (without extension)
base_name=$(basename "$PDB_FILE" .pdb)

# Define file paths for the trimmed PDB and PDBQT files
trimmed_pdb_file="$TRIMMED_DIR/${base_name}_trimmed.pdb"
pdbqt_file="$PDBQT_DIR/${base_name}.pdbqt"
log_file="$LOG_DIR/${base_name}_chimera.log"

echo "Processing $PDB_FILE..."

# Run ChimeraX to trim the PDB file and log output
echo "Running ChimeraX with command:"
echo "$chimera_path --nogui --cmd 'open $PDB_FILE; delete solvent; delete ions; delete ligand; save $trimmed_pdb_file; close all; exit'"

$chimera_path --nogui --cmd "open $PDB_FILE; delete solvent; delete ions; delete ligand; save $trimmed_pdb_file; close all; exit" > "$log_file" 2>&1

# Check if the trimmed PDB file was created successfully
if [[ -s "$trimmed_pdb_file" ]]; then
  echo "Trimmed PDB file created successfully: $trimmed_pdb_file"
  # Convert the trimmed PDB file to PDBQT format using OpenBabel and log output
obabel "$trimmed_pdb_file" -O "$pdbqt_file" -h -r > "${log_file%.log}_obabel.log" 2>&1

  if [[ -s "$pdbqt_file" ]]; then
    echo "PDBQT file created successfully: $pdbqt_file"
  else
    echo "Error: PDBQT file was not created or is empty: $pdbqt_file" | tee -a "$log_file"
  fi
else
  echo "Error: $trimmed_pdb_file was not created or is empty." | tee -a "$log_file"
fi

echo "Processing completed."
