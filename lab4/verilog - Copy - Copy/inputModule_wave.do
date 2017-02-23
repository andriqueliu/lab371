onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /inputModule_testbench/clk
add wave -noupdate /inputModule_testbench/reset
add wave -noupdate /inputModule_testbench/arriving
add wave -noupdate /inputModule_testbench/departing
add wave -noupdate /inputModule_testbench/arrivingOut
add wave -noupdate /inputModule_testbench/departingOut
add wave -noupdate /inputModule_testbench/gateR
add wave -noupdate /inputModule_testbench/gateL
add wave -noupdate /inputModule_testbench/gateROut
add wave -noupdate /inputModule_testbench/gateLOut
add wave -noupdate /inputModule_testbench/gondInRIn
add wave -noupdate /inputModule_testbench/gondInLIn
add wave -noupdate /inputModule_testbench/gondInChamberIn
add wave -noupdate /inputModule_testbench/gondInRLEDR
add wave -noupdate /inputModule_testbench/gondInLLEDR
add wave -noupdate /inputModule_testbench/gondInChamberLEDR
add wave -noupdate /inputModule_testbench/increaseEnable
add wave -noupdate /inputModule_testbench/decreaseEnable
add wave -noupdate /inputModule_testbench/arrivingEnable
add wave -noupdate /inputModule_testbench/increaseEnableOut
add wave -noupdate /inputModule_testbench/decreaseEnableOut
add wave -noupdate /inputModule_testbench/arrivingEnableOut
add wave -noupdate /inputModule_testbench/increaseBusy
add wave -noupdate /inputModule_testbench/decreaseBusy
add wave -noupdate /inputModule_testbench/arrivingBusy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2161 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
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
WaveRestoreZoom {0 ps} {7041 ps}
