onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lfsr10b_testbench/clk
add wave -noupdate /lfsr10b_testbench/reset
add wave -noupdate -radix unsigned /lfsr10b_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1809 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
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
WaveRestoreZoom {148 ps} {2572 ps}
