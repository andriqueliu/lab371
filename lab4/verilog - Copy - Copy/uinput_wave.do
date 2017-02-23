onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uinput_testbench/clk
add wave -noupdate /uinput_testbench/reset
add wave -noupdate /uinput_testbench/in
add wave -noupdate /uinput_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {67 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 290
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
WaveRestoreZoom {0 ps} {1772 ps}
