onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dataCollectTop_testbench/clk
add wave -noupdate /dataCollectTop_testbench/reset
add wave -noupdate -radix unsigned /dataCollectTop_testbench/data
add wave -noupdate /dataCollectTop_testbench/dut/delayItr
add wave -noupdate /dataCollectTop_testbench/startWrite
add wave -noupdate /dataCollectTop_testbench/dut/writeReady
add wave -noupdate /dataCollectTop_testbench/startRead
add wave -noupdate /dataCollectTop_testbench/dut/readReady
add wave -noupdate /dataCollectTop_testbench/clkLight
add wave -noupdate /dataCollectTop_testbench/transferBit
add wave -noupdate /dataCollectTop_testbench/dut/i
add wave -noupdate /dataCollectTop_testbench/clkOut
add wave -noupdate /dataCollectTop_testbench/lights
add wave -noupdate /dataCollectTop_testbench/dut/out_en
add wave -noupdate /dataCollectTop_testbench/dut/active
add wave -noupdate /dataCollectTop_testbench/dut/RW
add wave -noupdate /dataCollectTop_testbench/dut/address
add wave -noupdate -radix unsigned -childformat {{{/dataCollectTop_testbench/dut/collector/stored_memory[0]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[1]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[2]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[3]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[4]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[5]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[6]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[7]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[8]} -radix unsigned} {{/dataCollectTop_testbench/dut/collector/stored_memory[9]} -radix unsigned}} -expand -subitemconfig {{/dataCollectTop_testbench/dut/collector/stored_memory[0]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[1]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[2]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[3]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[4]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[5]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[6]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[7]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[8]} {-height 15 -radix unsigned} {/dataCollectTop_testbench/dut/collector/stored_memory[9]} {-height 15 -radix unsigned}} /dataCollectTop_testbench/dut/collector/stored_memory
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14650 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 240
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
WaveRestoreZoom {12381 ps} {17773 ps}
