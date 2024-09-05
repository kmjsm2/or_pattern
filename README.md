# README Guide for AutoDock Vina Batch Docking Script

# Overview 
`This script automates the docking process for multiple receptor and ligand files using AutoDock Vina. It loops through all ligand files in a specified directory and docks them against all receptor files in another specified directory. The results, including affinity values, are saved in CSV files, with each ligand-receptor pair's docking output and log files stored in organized directories.
## Prerequisite  
`
- AutoDock Vina: Ensure that AutoDock Vina is installed and accessible via the path specified in the script (vina_path). The script assumes you are using AutoDock Vina version 1.1.2.
- Bash: This script is designed to be run in a Unix-like environment with Bash.
- Openbabel
- ChimeraX
- Pymol
- python tool
  
## Directory Structure   
`
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

## 
required arguments:
  {scatter,convert}  Mode of operation: scatter for scatter plot, convert for gene expression conversion
  file1              Path to the first file, need to have column gene_id and FPKM for convert and TPM for scatter
  file2              Path to the second file (not required for convert mode), need to have column TPM for scatter
  out_dir            Directory to save the output plot or converted files
options:
  -h, --help            show this help message and exit
  --x_label X_LABEL     Label for x-axis
  --y_label Y_LABEL     Label for y-axis
  --p_title P_TITLE     Title of the scatter plot
  --o_title O_TITLE     Name of the output scatter plot file
  --converted CONVERTED
                        Name of the output file for convert mode
  --input_dir INPUT_DIR
                        Directory containing input files for batch conversion, files must be ending with _fpkm.csv and each file have column gene_id and FPKM
```
Example to use convert: 
```
quantgene convert benchmark/Chow_Rep1.genes.results ./
```
Above code will convert the FPKM value to TPM value. When the input already have existing column TPM like this input, it will generate new column as Calc_TPM, otherwise TPM. 

Example to use scatter:
``` 
quantgene scatter benchmark/Chow_Rep1.genes.results benchmark/Chow_Rep2.genes.results ./
```
Takes in two files with TPM value and save the image of scatter plot of TPM values. 


