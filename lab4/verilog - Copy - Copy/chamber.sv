/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

chamber operates the chamber between the two bodies of water. chamber tracks whether the
gondola is inside the chamber or in the adjacent bodies of water.
*/
module chamber (clk, reset, gateR, gateL,
					 gondInWater, gondInR, gondInL,
					 rightGood, leftGood);
	input  logic clk, reset;         // Clock and reset signals
	input  logic gateR, gateL;       // Open/close left and right gates
	output logic gondInWater;        // Is gondola in this body of water?
	// Is the gondola in the right or left body of water?
	input  logic gondInR, gondInL;
	// Are the right/left water differentials good?
	input  logic rightGood, leftGood;
	
	// State variables
	// Is the gondola in, or is the gondola outside this body of water?
	enum { IN, OUT } ps, ns;
	
	// Combinational/Next State logic
	// When changing states, rightWater will keep its current output for one cycle.
	// This allows other modules to see its behavior
	always_comb begin
		case (ps)
			IN:
				if ((rightGood && gateR) ||
			       (leftGood  && gateL)) begin
					ns = OUT;
					gondInWater = 1;
				end else begin
					ns = IN;
					gondInWater = 1;
				end
			OUT:
				if ((rightGood && gateR && gondInR) ||
				    (leftGood  && gateL && gondInL)) begin
					ns = IN;
					gondInWater = 0;
				end else begin
					ns = OUT;
					gondInWater = 0;
				end
		endcase
	end
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= OUT;
		end else begin
			ps <= ns;
		end
	end
	
endmodule
