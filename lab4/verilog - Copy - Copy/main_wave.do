onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main_testbench/whichClock
add wave -noupdate /main_testbench/CLOCK_50
add wave -noupdate /main_testbench/HEX0
add wave -noupdate /main_testbench/HEX1
add wave -noupdate /main_testbench/HEX2
add wave -noupdate /main_testbench/HEX3
add wave -noupdate /main_testbench/HEX4
add wave -noupdate /main_testbench/HEX5
add wave -noupdate /main_testbench/LEDR
add wave -noupdate /main_testbench/KEY
add wave -noupdate /main_testbench/SW
add wave -noupdate /main_testbench/GPIO_0
add wave -noupdate /main_testbench/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 195
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
WaveRestoreZoom {0 ps} {942 ps}
