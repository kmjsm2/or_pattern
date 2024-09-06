# README Guide for AutoDock Vina Batch Docking Script

# Overview 
This script automates the docking process for multiple receptor and ligand files using AutoDock Vina. It loops through all ligand files in a specified directory and docks them against all receptor files in another specified directory. The results, including affinity values, are saved in CSV files, with each ligand-receptor pair's docking output and log files stored in organized directories.
## Prerequisite  

- AutoDock Vina: Ensure that AutoDock Vina is installed and accessible via the path specified in the script (vina_path). The script assumes you are using AutoDock Vina version 1.1.2.
- Bash: This script is designed to be run in a Unix-like environment with Bash.
- Openbabel
- ChimeraX
- Pymol
- python tool
  
## Directory Structure   

- Receptor Directory (RECEPTOR_DIR): Contains PDBQT files for all receptors.
- Ligand Directory (LIGAND_DIR): Contains PDBQT files for all ligands.
- Output Base Directory (BASE_OUTPUT_DIR): Contains three subdirectories:
  
    `-- pdbqt: Stores docking output files (.pdbqt).
    `-- log: Stores log files (.txt).
    `-- csv: Stores CSV files with docking results.

## Basic usage

1. Navigate to the Script Directory:
```
cd /path/to/your/script_directory
```

2. Make the Script Executable (Optional): 
```
chmod +x script_name.sh
```

3. Run the Script:
```
./script_name.sh
```
  a. An alternative way to run the script: 
```
bash script_name.sh
```

4. Monitor the Process:
 The script will start the docking process for each ligand-receptor pair. You will see output in the terminal indicating the progress of each docking job.

6. View the Results:
Once complete, navigate to the output directory to view the results. 

## file summary

# Cleaning PDB files Step
1. clean_pdb.py:
This Python script uses PyMOL to process PDB files by removing water molecules and adding missing hydrogens. It fetches the input and output directories from environment variables, iterates through all PDB files in the input directory, applies the cleaning steps, and saves the cleaned files to the output directory. Each structure is cleared from memory after processing.

2. clena_pdb.sh:
This bash script sets up input and output directories, checks if the input directory exists, lists its contents, and then runs a PyMOL script to clean PDB files by setting environment variables for the directories.

# Trimming and Converting into PDBQT files Step 
1. multi_conversion.sh:
This script automates the conversion of PDB files into PDBQT format by trimming unnecessary parts (solvents, ions, ligands) and converting the clean structure using OpenBabel, logging all processes for error tracking. (uses openbabel for file conversion and Chimera X for trimming)

2. chi_convert_pdb_to_pdbqt.sh:
This script is structured similarly to the one you previously shared, but it's designed to process a single PDB file. 
  
# Molecular Docking via Autodock Vina
1. run_vina_from_txt_v5.sh: 
This automates the docking of multiple ligands with multiple receptors using AutoDock Vina, organizing the results and logs into separate directories, and saving docking affinities to CSV files for each ligand.

2. remain_create_file.sh:
This bash script handles unexpected interruptions during the execution of 'run_vina_from_txt_v5.sh' by identifying ligands and receptors that have not been processed yet and organizing them into a newly created folder for easy continuation of the docking process.

3. remain_conversion_pdbqt.sh:
The script 'remain_conversion_pdbqt.sh' processes the conversion of remaining files into PDBQT format, based on the files identified and prepared by 'remain_create_file.sh'.

4. run_vina_from_txt_v4.sh: 
'run_vina_from_txt_v4.sh' handles the docking process specifically for remaining files by specifying the output directory. These scripts work together to ensure that both new and remaining files are processed efficiently, with a clear organization of outputs and results.

   



