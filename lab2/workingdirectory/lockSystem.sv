/*

*/
module lockSystem (clk, reset, );
	input  logic clk, reset;
	input  logic increase, decrease;
	input  logic gateR, gateL;
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
	gate leGate ();
	gate riGate ();
	
endmodule
