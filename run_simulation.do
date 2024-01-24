
# Compile the design
vsim work.Datapath_TB

# Add signals to the wave window
add wave -position insertpoint sim:/Datapath_TB/*

# Zoom range
wave zoom range 0ns 50ns

# Run the simulation
run 1000us

# Quit right after
quit
