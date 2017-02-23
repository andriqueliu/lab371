onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /timerEnabled_testbench/clk
add wave -noupdate /timerEnabled_testbench/reset
add wave -noupdate /timerEnabled_testbench/beginTimer
add wave -noupdate /timerEnabled_testbench/enable
add wave -noupdate /timerEnabled_testbench/dut/ctr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1104 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 275
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
WaveRestoreZoom {0 ps} {3352 ps}
