// EE 371 Lab 2 Project
// chamber 


// Left body of water is at +3 feet relative to chamber default
// Right body of wateris at -3 feet relative to chamber default
module chamber (clk, reset, gateR, gateL, increase, decrease, gondIn);
	input  logic clk, reset;         // Clock and reset signals
	input  logic gateR, gateL;       // Open/close left and right gates
	input  logic increase, decrease; // Increase/decrease water level
	output logic gondIn;             // Is gondola in?
	
	int level;
	
	
	// Set default water level
	initial begin
		level = 0;
		
	end
	
	
	
	input  logic 		 CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input  logic [3:0] KEY; // True when not pressed, False when pressed (For the physical board)
	input  logic [9:0] SW;
	
	
	
endmodule
