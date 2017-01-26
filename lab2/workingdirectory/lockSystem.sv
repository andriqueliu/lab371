/*

*/
module lockSystem (clk, reset, );
	input  logic clk, reset;
	input  logic increase, decrease;
	input  logic gateR, gateL; // Open/close left and right gates
	output logic gondInL, gondInChamber, gondInR;
	output logic gateRClosed, gateLClosed;
	
	chamberWater chWater (.clk, .reset, .increase, .decrease,
	                      .rightGood(), .leftGood());
	chamber ch (.clk, .reset, .gateR, .gateL,
					.gondInWater, .gondInR, .gondInL,
					.rightGood, .leftGood);
	leftWater  leWater (.clk, .reset, .gateL, .waterLevelsGood,
	                    .gondInChamber, .gondInWater););
	rightWater riWater (.clk, .reset, .gateR, .waterLevelsGood,
	                    .gondInChamber, .gondInWater);
	gate leGate (.clk, .reset, .openSignal(gateL), .gateClosed(gateLClosed));
	gate riGate (.clk, .reset, .openSignal(gateR), .gateClosed(gateRClosed));
	
endmodule
