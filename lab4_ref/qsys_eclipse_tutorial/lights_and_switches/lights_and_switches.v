module lights_and_switches(LED, SW, clk, rst);
	input clk, rst;
	input [7:0] SW;
	output [7:0] LED;
	
	nios2 processor (.clk_clk(clk), .leds_export(LED), .reset_reset_n(rst), .switches_export(SW));
endmodule
