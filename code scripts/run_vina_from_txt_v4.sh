#!/bin/bash

# Directory containing receptor PDBQT files
RECEPTOR_DIR="/Users/zoekim/Desktop/l3/aroma_result/pdbqt/Naringin_remain"
# Ligand PDBQT file
LIGAND_FILE="/Users/zoekim/Desktop/l3/aroma_sub_pdbqt/citrus/Naringin.pdbqt"
# Output directory for PDBQT files
OUTPUT_DIR="/Users/zoekim/Desktop/l3/aroma_result/pdbqt/Naringin_remain_result"
# Log directory
LOG_DIR="/Users/zoekim/Desktop/l3/aroma_result/log/Naringin"
# CSV file for affinities
CSV_FILE="/Users/zoekim/Desktop/l3/aroma_result/csv/Naringin_remain.csv"

# Create directories if they don't exist
mkdir -p "$OUTPUT_DIR"
# mkdir -p "$LOG_DIR"

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

# Initialize CSV file
echo "Receptor,Affinity (kcal/mol)" > "$CSV_FILE"

# Loop through all receptor PDBQT files in the directory
for receptor_file in "$RECEPTOR_DIR"/*.pdbqt; do
  # Get the base name of the receptor file (without extension)
  base_name=$(basename "$receptor_file" .pdbqt)
  
  # Define output and log file paths
  output_file="$OUTPUT_DIR/${base_name}_out.pdbqt"
  log_file="$LOG_DIR/${base_name}_log.txt"
  
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
  
  # Append receptor name and affinity to CSV file
  if [ -n "$affinity" ]; then
    echo "$base_name,$affinity" >> "$CSV_FILE"
  else
    echo "$base_name,N/A" >> "$CSV_FILE"
  fi

  echo "Docking completed for receptor: $receptor_file with affinity $affinity"
done

echo "All docking processes completed. Affinities saved to $CSV_FILE."
