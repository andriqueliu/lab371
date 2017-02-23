onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tow_testbench/whichClock
add wave -noupdate /tow_testbench/HEX5
add wave -noupdate /tow_testbench/HEX0
add wave -noupdate /tow_testbench/LEDR
add wave -noupdate /tow_testbench/KEY
add wave -noupdate {/tow_testbench/SW[9]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {361674091 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 234
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
WaveRestoreZoom {245628928 ps} {736886784 ps}
