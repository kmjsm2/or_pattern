#!/bin/bash

# Directory containing receptor PDBQT files
RECEPTOR_DIR="/Users/zoekim/Desktop/l3/vina_OR/trimmed_pdbqt"
# Directory containing ligand PDBQT files
LIGAND_DIR="/Users/zoekim/Desktop/l3/aroma_sub_pdbqt/woody"
# Base directory for output, log, and CSV files
BASE_OUTPUT_DIR="/Users/zoekim/Desktop/l3/aroma_result/woody"

# Create base output directories if they don't exist
mkdir -p "$BASE_OUTPUT_DIR/pdbqt"
mkdir -p "$BASE_OUTPUT_DIR/log"
mkdir -p "$BASE_OUTPUT_DIR/csv"

# AutoDock Vina executable path
vina_path="/Users/zoekim/Downloads/autodock_vina_1_1_2_mac_catalina_64bit/bin/vina"

# Docking parameters
center_x=10.162
center_y=6.378
center_z=-4.587
size_x=100
size_y=100
size_z=100
cpu=1
num_modes=10
exhaustiveness=16
energy_range=4

# Loop through all ligand PDBQT files in the directory
for LIGAND_FILE in "$LIGAND_DIR"/*.pdbqt; do
  # Get the base name of the ligand file (without extension)
  ligand_name=$(basename "$LIGAND_FILE" .pdbqt)

  # Define directories for this ligand
  OUTPUT_DIR="$BASE_OUTPUT_DIR/pdbqt/$ligand_name"
  LOG_DIR="$BASE_OUTPUT_DIR/log/$ligand_name"
  CSV_FILE="$BASE_OUTPUT_DIR/csv/${ligand_name}.csv"

  # Create directories if they don't exist
  mkdir -p "$OUTPUT_DIR"
  mkdir -p "$LOG_DIR"

  # Initialize CSV file
  echo "Ligand,Receptor,Affinity (kcal/mol)" > "$CSV_FILE"

  # Loop through all receptor PDBQT files in the directory
  for receptor_file in "$RECEPTOR_DIR"/*.pdbqt; do
    # Get the base name of the receptor file (without extension)
    receptor_name=$(basename "$receptor_file" .pdbqt)
    
    # Define output and log file paths
    output_file="$OUTPUT_DIR/${receptor_name}_out.pdbqt"
    log_file="$LOG_DIR/${receptor_name}_log.txt"
    
    # Run AutoDock Vina
    "$vina_path" --receptor "$receptor_file" \
       --ligand "$LIGAND_FILE" \
       --center_x $center_x \
       --center_y $center_y \
       --center_z $center_z \
       --size_x $size_x \
       --size_y $size_y \
       --size_z $size_z \
       --cpu $cpu \
       --num_modes $num_modes \
       --exhaustiveness $exhaustiveness \
       --energy_range $energy_range \
       --out "$output_file" \
       --log "$log_file"
    
    # Extract the first affinity value from the log file
    affinity=$(grep -m 1 "^   1" "$log_file" | awk '{print $2}')
    
    # Append ligand name, receptor name, and affinity to CSV file
    if [ -n "$affinity" ]; then
      echo "$ligand_name,$receptor_name,$affinity" >> "$CSV_FILE"
    else
      echo "$ligand_name,$receptor_name,N/A" >> "$CSV_FILE"
    fi

    echo "Docking completed for ligand: $LIGAND_FILE and receptor: $receptor_file with affinity $affinity"
  done
done

echo "All docking processes completed. Affinities saved to respective CSV files."
