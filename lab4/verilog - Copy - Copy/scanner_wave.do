onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /scanner_testbench/clk
add wave -noupdate /scanner_testbench/reset
add wave -noupdate /scanner_testbench/beginScanning
add wave -noupdate /scanner_testbench/beginTransfer
add wave -noupdate /scanner_testbench/status
add wave -noupdate /scanner_testbench/readyToTransfer
add wave -noupdate /scanner_testbench/bufferAmount
add wave -noupdate /scanner_testbench/startScanningOut
add wave -noupdate /scanner_testbench/dut/level80
add wave -noupdate /scanner_testbench/dut/level90
add wave -noupdate /scanner_testbench/dut/level100
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8750 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
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
WaveRestoreZoom {0 ps} {13728 ps}
