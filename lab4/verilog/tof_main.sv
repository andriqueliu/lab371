// Andrique Liu

// Two inputs: SW0 and SW1 to indicate wind direction
// Three lights to express sequence of lights
// Switches will never both be true
// SW may be changed at any point during cycling, and lights
// must switch over ASAP (however, can enter into any point
// of other pattern's behaviors
module tof_main (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  logic 		 CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input  logic [3:0] KEY; // True when not pressed, False when pressed
	input  logic [9:0] SW;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 25;
	clock_divider cdiv (CLOCK_50, clk);
	
//	// Hook up FSM inputs and outputs.
//	logic reset, w, out;
//	assign reset = ~KEY[0]; // Reset when KEY[0] is pressed.
//	assign w = ~KEY[1];
	logic reset;
	assign reset = ~KEY[0]; // Reset when KEY[0] is pressed.
	
//	simple s (.clk(clk[whichClock]), .reset, .w, .out);
	hzd_fsm fsm (.clk(clk[whichClock]), .reset, .SW(SW[1:0]), .LEDR(LEDR[2:0]));
	
//	// Show signals on LEDRs so we can see what is happening.
//	assign LEDR = { clk[whichClock], 1'b0, reset, 2'b0, out};
	
endmodule
	
// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
// [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
	input  logic          clock;
	output logic [31:0]	 divided_clocks;
	
	initial
		divided_clocks <= 0;
	
	always_ff @(posedge clock)
		divided_clocks <= divided_clocks + 1;
endmodule

// testbench for tof_main