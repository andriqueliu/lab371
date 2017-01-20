// DE1_SoC.v
// EE 371 Lab 1 Project
//	DE1_SoC is the highest level module of this project, and connects
// board peripherals, I/O, and more
//	Authors: Nikhil Grover, Emraj Sidhu, Andrique Liu
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  		 CLOCK_50; //50MHz clock
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input  [3:0] KEY;
	input  [9:0] SW;
	
	// Generate clk off of CLOCK_50, whichClock picks rate
	wire [31:0] clk;
	parameter whichClock = 24;
	clock_divider cdiv (CLOCK_50, clk);
	
	// Hook up FSM inputs and outputs
	wire reset;
	wire [3:0] out1, out2;
	assign reset = SW[0];		// Reset when SW[0] is switched on
	
	// Note: CLOCK_50 is used for signal tap, but divided clock
	// with whichClock = 24 is used for live demo
	RippleDown Counter1 (.qOut(out2), .clk(CLOCK_50), .rst(reset));      // Ripple down counter
//	SyncDown Counter2 (.qOut(out2), .clk(CLOCK_50), .rst(reset));        // Sync down counter... fix
//	JohnsonCounter Counter3 (.out(out2), .clk(CLOCK_50), .rst(reset));   // Sync Johnson counter
//	DownCounter_Schematic Counter4 (.Clk(CLOCK_50), .Output(out2), .Reset(reset));
	
	// Show signals on LEDRs
	// Eight LEDs are enabled during demo to for faster demo
	// Four LEDs are enabled during signal tap to test individual counters
	assign LEDR [7:4] = out1;
	assign LEDR [3:0] = out2;
	
endmodule

// clock_divider is used to divide the clock, slowing down the main clock
// down so that the LEDs are visible. 
// divided_clocks[0] = 25MHz, [1] = 12.5MHz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75 Hz, ...
module clock_divider (clock, divided_clocks); 
	input				clock;
	output reg [31:0]	divided_clocks;
	
	initial
		divided_clocks <= 32'b0;
	
	always@(posedge clock)
		divided_clocks <= divided_clocks + 1;
endmodule
