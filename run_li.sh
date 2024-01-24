#!/bin/bash

script_dir="$(dirname "$(readlink -f "$0")" )"
export PATH=$PATH:~/Documents/VHDL_Projects/ModelSim/modelsim_ase/bin

# Create random numbers separated by space
# to test the UUT
python3 scripts/create_random.py

# Run the Simulation to get the output
# that will be in the tb_output.txt file
vsim -c -do "$script_dir/run_simulation.do"

# Validate the UUT output which will log any design
# errors in the log directory
python3 scripts/validate.py
