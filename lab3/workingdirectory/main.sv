/*




*/
module main (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	input  logic 		  CLOCK_50; // 50MHz clock.
	output logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic  [9:0] LEDR;
	input  logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
	input  logic  [9:0] SW;
//	output logic [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
	inout  [35:0] GPIO_0;
	
	
	// 
	logic [31:0] clk;
	parameter whichClock = 21;   // Roughly 12 Hz
	clock_divider cdiv (CLOCK_50, clk);
	
	
	logic  [7:0] lights;
	
	assign LEDR[7:0] = lights;
	
	logic  reset, startWrite, startRead;
	assign reset = ~KEY[3];
//	assign LEDR[7:0] = lights[6:0];
//	assign LEDR[9] = lights[9];     // !!! This LEDR is used as a reference clock.
	assign startWrite = SW[9];
	assign startRead  = SW[8];
	
	
	// 
	dataCollectTop collectTop (.clk(clk[whichClock]), .reset, .data( ),
	                           .startWrite, .startRead, .clkLight(LEDR[9]),
										.transferBit(GPIO_0[35]), .clkOut(GPIO_0[34]));
	
	
	
	
	
	
	
endmodule
