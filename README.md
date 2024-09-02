# or_pattern

run_vina_from_txt_v5.sh

Prerequisites
AutoDock Vina: Ensure that AutoDock Vina is installed and accessible via the path specified in the script (vina_path). The script assumes you are using AutoDock Vina version 1.1.2.
Bash: This script is designed to be run in a Unix-like environment with Bash.
Directory Structure
Receptor Directory (RECEPTOR_DIR): Contains PDBQT files for all receptors.
Ligand Directory (LIGAND_DIR): Contains PDBQT files for all ligands.
Output Base Directory (BASE_OUTPUT_DIR): Contains three subdirectories:
pdbqt: Stores docking output files (.pdbqt).
log: Stores log files (.txt).
csv: Stores CSV files with docking results.

