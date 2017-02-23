onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dataCollector_testbench/clk
add wave -noupdate /dataCollector_testbench/reset
add wave -noupdate /dataCollector_testbench/startScanning
add wave -noupdate /dataCollector_testbench/displayData
add wave -noupdate /dataCollector_testbench/dut/enableSecond
add wave -noupdate /dataCollector_testbench/dut/data
add wave -noupdate /dataCollector_testbench/dut/ctr
add wave -noupdate -expand /dataCollector_testbench/dut/dataBuffer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3281 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 297
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
WaveRestoreZoom {0 ps} {12960 ps}
