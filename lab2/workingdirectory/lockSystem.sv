/*

I/O of modules:


*/
module lockSystem (clk, reset, increase, decrease, gateR, gateL,
                   gondInL, gondInChamber, gondInR,
						 gateRClosed, gateLClosed);
	input  logic clk, reset;         // Clock, reset
	input  logic increase, decrease; // Increase/decrease water levels
	input  logic gateR, gateL;       // Open/close left and right gates
	// Output to LEDRs; indicate where gondola is
	output logic gondInL, gondInChamber, gondInR;
	// Output to LEDRs; indicate whether gates are open or closed
	output logic gateRClosed, gateLClosed;
	
	// Intermediate signals
	// Connects chamberWater to water modules
	logic  rightGood, leftGood;
	// Connects water outputs to each other, as well as LEDR outputs
	logic  inLeft, inChamber, inRight;
	
	// Assign output signals to intermediate signals
	assign gondInL = inLeft;
	assign gondInR = inRight;
	assign gondInChamber = inChamber;

	chamberWater chWater (.clk, .reset, .increase, .decrease,
	                      .rightGood, .leftGood);
	chamber ch (.clk, .reset, .gateR, .gateL,
					.gondInWater(inChamber), .gondInR(inRight), .gondInL(inLeft),
					.rightGood, .leftGood);
	leftWater  leWater (.clk, .reset, .gateL(gateL), .waterLevelsGood(leftGood),
	                    .gondInChamber(inChamber), .gondInWater(inLeft));
	rightWater riWater (.clk, .reset, .gateR(gateR), .waterLevelsGood(rightGood),
	                    .gondInChamber(inChamber), .gondInWater(inRight));
	gate leGate (.clk, .reset, .openSignal(gateL), .gateClosed(gateLClosed));
	gate riGate (.clk, .reset, .openSignal(gateR), .gateClosed(gateRClosed));
	
	
	
endmodule
