import os
from pymol import cmd

# Fetch the environment variables for input and output directories
pdb_dir = os.getenv('pdb_dir')
output_dir = os.getenv('output_dir')

# Ensure the output directory exists
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# List all PDB files in the directory
pdb_files = [f for f in os.listdir(pdb_dir) if f.endswith('.pdb')]

# Process each PDB file
for pdb_file in pdb_files:
    full_path = os.path.join(pdb_dir, pdb_file)
    print(f"Processing {full_path}")

    cmd.load(full_path)

    # Remove waters
    cmd.remove("resn HOH")

    # Add missing hydrogens
    cmd.h_add()

    # Save the cleaned PDB file
    cleaned_pdb_file = os.path.join(output_dir, pdb_file)
    cmd.save(cleaned_pdb_file)

    # Clear all loaded structures before the next iteration
    cmd.delete("all")

# Quit PyMOL
cmd.quit()
