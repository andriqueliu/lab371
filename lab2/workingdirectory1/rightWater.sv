/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

rightWater acts as the body of water to the right of the chamber.
rightWater keeps track of whether the gondola is inside or outside.

Inputs:
This module takes inputs to: monitor when the right gate is opened, 
monitor if water levels match, whether the gondola is in the pound chamber.

Outputs:
This module outputs whether the gondola is currently in the right body
of water.

Note: water level is at -3 relative to the default chamber level.
*/
module rightWater (clk, reset, gateR, waterLevelsGood, gondInChamber, gondInWater);
	input  logic clk, reset;         // Clock and reset signals
	input  logic gateR;              // Open/close right gates
	input  logic waterLevelsGood;    // Are water levels even/can boat cross?
	// Note: water levels are good if the chamber is at -3
	// Higher level module will determine which waterLevelsGood (left or right)
	// to send.
	input  logic gondInChamber;     // Is the gondola in the pound chamber (adjacent)?
	output logic gondInWater;        // Is gondola in this body of water?
	
	// State variables
	// Is the gondola in, or is the gondola outside this body of water?
	enum { IN, OUT } ps, ns;
	
	// Combinational/Next State logic
	// When changing states, rightWater will keep its current output for one cycle.
	// This allows other modules to see its behavior
	always_comb begin
		case (ps)
			IN:
				if (waterLevelsGood && gateR) begin
					ns = OUT;
					gondInWater = 1;
				end else begin
					ns = IN;
					gondInWater = 1;
				end
			OUT:
				if (waterLevelsGood && gateR && gondInChamber) begin
					ns = IN;
					gondInWater = 0;
				end else begin
					ns = OUT;
					gondInWater = 0;
				end
		endcase
	end
	
	// Sequential Logic, operates on every posedge clk
	always_ff @(posedge clk)
		if (reset)
			ps <= IN; // At reset, go back to IN (gondola is in this body by default)
		else 
			ps <= ns; // Otherwise, go to the next state

endmodule

module rightWater_testbench();
	logic clk, reset;         // Clock and reset signals
	logic gateR;              // Open/close right gates
	logic waterLevelsGood;    // Are water levels even/can boat cross?
	logic gondInChamber;      // Is the gondola in the pound chamber?
	logic gondInWater;        // Is gondola in this body of water?
	
	rightWater dut (clk, reset, gateR, waterLevelsGood, gondInChamber, gondInWater);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	reset <= 1; 			  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	gateR <= 0; waterLevelsGood <= 0; gondInChamber <= 0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	waterLevelsGood <= 1;  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	gateR <= 1;				  @(posedge clk);
	gateR <= 0;				  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
