onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /beginActiveCounter_testbench/clk
add wave -noupdate /beginActiveCounter_testbench/reset
add wave -noupdate /beginActiveCounter_testbench/startStandby
add wave -noupdate /beginActiveCounter_testbench/startActive
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3419 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
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
WaveRestoreZoom {2378 ps} {9338 ps}
