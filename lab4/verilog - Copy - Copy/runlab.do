# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./clock_divider.sv"

#vlog "./beginActiveCounter.sv"
vlog "./dataBuffer.sv"
vlog "./scanner.sv"

vlog "./transferProcess.sv"

vlog "./timer.sv"

#vlog "./timerEnabled.sv"

vlog "./pctgDisplay.sv"
vlog "./stateDisplay.sv"

vlog "./dataCollect.sv"
vlog "./dataCollectTop.sv"
#vlog "./main.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work dataCollect_testbench
vsim -voptargs="+acc" -t 1ps -lib work dataCollectTop_testbench
#vsim -voptargs="+acc" -t 1ps -lib work main_testbench


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#do dataCollect_wave.do
do dataCollectTop_wave.do
#do main_wave.do


# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
