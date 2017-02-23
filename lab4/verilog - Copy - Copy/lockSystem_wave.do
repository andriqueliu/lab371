onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lockSystem_testbench/clk
add wave -noupdate /lockSystem_testbench/reset
add wave -noupdate /lockSystem_testbench/increase
add wave -noupdate /lockSystem_testbench/decrease
add wave -noupdate /lockSystem_testbench/gateR
add wave -noupdate /lockSystem_testbench/gateL
add wave -noupdate /lockSystem_testbench/gondInL
add wave -noupdate /lockSystem_testbench/gondInChamber
add wave -noupdate /lockSystem_testbench/gondInR
add wave -noupdate /lockSystem_testbench/gateRClosed
add wave -noupdate /lockSystem_testbench/gateLClosed
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2878 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {6864 ps}
