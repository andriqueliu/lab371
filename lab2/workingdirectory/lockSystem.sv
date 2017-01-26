/*

I/O of modules:


*/
module lockSystem (clk, reset, increase, decrease, gateR, gateL,
                   gondInL, gondInChamber, gondInR,
						 gateRClosed, gateLClosed);
	input  logic clk, reset;
	input  logic increase, decrease;
	input  logic gateR, gateL; // Open/close left and right gates
	output logic gondInL, gondInChamber, gondInR;
	output logic gateRClosed, gateLClosed;
	
	logic  rightGood, leftGood; // 
	logic  inLeft, inChamber, inRight;
	
	assign gondInL = inLeft;
	assign gondInR = inRight;
	assign gondInChamber = inChamber;
	
	// Outputs r and leftGood to r, lWater, and chamber
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
