onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Store_Manager_testbench/HEX0
add wave -noupdate /Store_Manager_testbench/HEX1
add wave -noupdate /Store_Manager_testbench/HEX2
add wave -noupdate /Store_Manager_testbench/HEX3
add wave -noupdate /Store_Manager_testbench/HEX4
add wave -noupdate /Store_Manager_testbench/HEX5
add wave -noupdate {/Store_Manager_testbench/LEDR[1]}
add wave -noupdate {/Store_Manager_testbench/LEDR[0]}
add wave -noupdate {/Store_Manager_testbench/SW[9]}
add wave -noupdate {/Store_Manager_testbench/SW[8]}
add wave -noupdate {/Store_Manager_testbench/SW[7]}
add wave -noupdate {/Store_Manager_testbench/SW[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 135
configure wave -valuecolwidth 258
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
WaveRestoreZoom {0 ps} {24364 ps}
