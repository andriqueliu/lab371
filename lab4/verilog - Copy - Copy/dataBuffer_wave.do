onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dataBuffer_testbench/clk
add wave -noupdate /dataBuffer_testbench/reset
add wave -noupdate /dataBuffer_testbench/beginScanning
add wave -noupdate /dataBuffer_testbench/level80
add wave -noupdate /dataBuffer_testbench/level90
add wave -noupdate /dataBuffer_testbench/level100
add wave -noupdate /dataBuffer_testbench/bufferAmount
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1941 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
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
WaveRestoreZoom {0 ps} {28160 ps}
