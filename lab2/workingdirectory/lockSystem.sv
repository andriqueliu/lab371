/*

I/O of modules:


*/
module lockSystem (clk, reset, increase, decrease, gateR, gateL,
                   gondInL, gondInChamber, gondInR,
						 gateRClosed, gateLClosed,
						 leftGo, rightGo);
	input  logic clk, reset;         // Clock, reset
	input  logic increase, decrease; // Increase/decrease water levels
	input  logic gateR, gateL;       // Open/close left and right gates
	// Output to LEDRs; indicate where gondola is
	output logic gondInL, gondInChamber, gondInR;
	// Output to LEDRs; indicate whether gates are open or closed
	output logic gateRClosed, gateLClosed;
	
	output logic leftGo, rightGo;
	assign leftGo = leftGood;
	assign rightGo = rightGood;
	
	// Intermediate signals
	// Connects chamberWater to water modules
	logic  rightGood, leftGood;
	// Connects water outputs to each other, as well as LEDR outputs
	logic  inLeft, inChamber, inRight;
	
	// Assign output signals to intermediate signals
	assign gondInL = inLeft;
	assign gondInR = inRight;
	assign gondInChamber = inChamber;
	// Assign gate LEDs...
	
	// Hook up modules together
	chamberWater chWater (.clk, .reset, .increase, .decrease,
	                      .rightGood(rightGood), .leftGood(leftGood));
	chamber ch (.clk, .reset, .gateR, .gateL,
					.gondInWater(inChamber), .gondInR(inRight), .gondInL(inLeft),
					.rightGood(rightGood), .leftGood(leftGood));
					//
	leftWater  leWater (.clk, .reset, .gateL, .waterLevelsGood(leftGood),
	                    .gondInChamber(inChamber), .gondInWater(inLeft));
	rightWater riWater (.clk, .reset, .gateR, .waterLevelsGood(rightGood),
	                    .gondInChamber(inChamber), .gondInWater(inRight));
//	gate leGate (.clk, .reset, .openSignal(gateL), .gateClosed(gateLClosed));
//	gate riGate (.clk, .reset, .openSignal(gateR), .gateClosed(gateRClosed));
	
endmodule

//module lockSystem_testbench();
//	logic clk, reset;         // Clock, reset
//	logic increase, decrease; // Increase/decrease water levels
//	logic gateR, gateL;       // Open/close left and right gates
//	// Output to LEDRs; indicate where gondola is
//	logic gondInL, gondInChamber, gondInR;
//	// Output to LEDRs; indicate whether gates are open or closed
//	logic gateRClosed, gateLClosed;
//	
//	lockSystem dut (clk, reset, increase, decrease, gateR, gateL,
//                   gondInL, gondInChamber, gondInR,
//						 gateRClosed, gateLClosed);
//	
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	initial begin
//								  @(posedge clk);
//	reset <= 1; 			  @(posedge clk);
//								  @(posedge clk);
//	reset <= 0;            @(posedge clk);
//								  @(posedge clk);
////	gateR <= 1;            @(posedge clk);
//	decrease <= 1;         @(posedge clk);
//	decrease <= 0;         @(posedge clk);
//	decrease <= 1;         @(posedge clk);
//	decrease <= 0;         @(posedge clk);
//	decrease <= 1;         @(posedge clk);
//	decrease <= 0;         @(posedge clk);
//	decrease <= 1;         @(posedge clk);
//	decrease <= 0;         @(posedge clk);
//	decrease <= 1;         @(posedge clk);
//	decrease <= 0;         @(posedge clk);
//	decrease <= 1;         @(posedge clk); // 6
//	decrease <= 0;         @(posedge clk);
//								  @(posedge clk);
//	gateR <= 1;            @(posedge clk);
//	gateR <= 0;            @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	$stop; // End the simulation.
//	end
//endmodule
