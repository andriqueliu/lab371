/*




*/
module main (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	input  logic 		  CLOCK_50; // 50MHz clock.
	output logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic  [9:0] LEDR;
	input  logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
	input  logic  [9:0] SW;
	inout  [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
	
	// 
	logic [31:0] clk;
	parameter whichClock = 15;   // Roughly 768 Hz
//	parameter whichClock = 5;
	clock_divider cdiv (CLOCK_50, clk);
	
	// 
	logic  reset, startWrite, startRead;
	assign reset = ~KEY[3];
	assign startWrite = SW[9];
	assign startRead  = SW[8];
	
	assign LEDR[9] = clk[whichClock];
	
	logic  testSerial, testClkOut;
	
	assign GPIO_0[35] = testSerial; // For some reason GPIO35 is working, but not 34?
	                                // Trying 34 by hooking clkout to a logic first, then
											  // assigning that logic to the GPIO???
//	assign LEDR[8] = testSerial;

//	assign LEDR[8] = testClkOut;
//	assign GPIO_0[34] = testClkOut;
	
	always_comb begin
		if (startRead) begin
			GPIO_0[34] = clk[whichClock];
			LEDR[8] = clk[whichClock];
		end else begin
			GPIO_0[34] = 1'b0;
			LEDR[8] = 1'b0;
		end
	end
	
//	// !!! this module also has to have an 
	dataCollectTop collectTop (.clk(clk[whichClock]), .reset, .data( ),
	                           .startWrite, .startRead, .clkLight( ),
										.transferBit(testSerial), .clkOut(testClkOut),
										.lights(LEDR[7:0]),
										.stateHEX(HEX4),
										.pctgHEX(HEX5));
	
	transfer transferTop(.clk(clk[whichClock]), .reset, .data_scanner(GPIO_0[35]), .ready); //Check where the "ready" needs to map to
	
	
	
	
	
endmodule

//// Tester Module
//module main_testbench();
//	logic 		 CLOCK_50; // 50MHz clock.
//	logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
//	logic  [9:0] LEDR;
//	logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
//	logic  [9:0] SW;
////	output logic [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
//	wire  [35:0] GPIO_0;
//	
//	main dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
//	
//	// Set up the clock.
////	parameter CLOCK_PERIOD=100;
////	initial begin
////		clk <= 0;
////		forever #(CLOCK_PERIOD/2) clk <= ~clk;
////	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	// Test... set direction to pass data in
//	// Then clear direction to read data
//	initial begin
//								  @(posedge clk);
//	KEY[3] <= 1;            @(posedge clk);
//	KEY[0] <= 0;            @(posedge clk);
//	@(posedge clk);
//	@(posedge clk);
//	SW[9] <= 1;
//						repeat (250) @(posedge clk);
//	SW[8] <= 1;
//						repeat (80) @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	$stop; // End the simulation.
//	end
//endmodule
