// Andrique Liu

// Top-level module that defines the I/Os for the DE-1 SoC board
// Manage two hex displays using 8 switch inputs
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
   output logic [6:0]     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]	  LEDR;
	input  logic [3:0]     KEY;
	input  logic [9:0]      SW;
	
	// Lab logic
	seg7 Hex0 (.bcd(SW[3:0]), .leds(HEX0[6:0]));
	seg7 Hex1 (.bcd(SW[7:4]), .leds(HEX1[6:0]));
endmodule 

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	// Try all combinations of inputs. 
	integer i;
	initial begin
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for (i = 0; i < 16; i++) begin
			{SW[7], SW[6], SW[5], SW[4]} = i;
			{SW[3], SW[2], SW[1], SW[0]} = i; #10;
		end
	end
endmodule 