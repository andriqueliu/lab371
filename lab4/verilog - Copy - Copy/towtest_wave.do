onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /towtest_testbench/CLOCK_50
add wave -noupdate {/towtest_testbench/SW[9]}
add wave -noupdate /towtest_testbench/LEDR
add wave -noupdate /towtest_testbench/KEY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {498 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 252
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
WaveRestoreZoom {0 ps} {1832 ps}
