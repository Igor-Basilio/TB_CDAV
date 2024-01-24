
# Get the directory of the script
$scriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Update the PATH environment variable
$env:PATH += ";C:\Users\YourUsername\Documents\VHDL_Projects\ModelSim\modelsim_ase\bin"

# Create random numbers separated by space to test the UUT
python scripts\create_random.py

# Run the Simulation to get the output in the tb_output.txt file
vsim -c -do "$scriptDir\run_simulation.do"

# Validate the UUT output which will log any design errors in the log directory
python scripts\validate.py

