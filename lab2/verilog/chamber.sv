// EE 371 Lab 2 Project
// chamber acts as a high level module; chamber manages each body of water,
// 


// Left body of water is at +3 feet relative to chamber default
// Right body of water is at -3 feet relative to chamber default
module chamber (clk, reset, gateR, gateL, increase, decrease,
					 gondInWater, gondInR, gondInL);
	input  logic clk, reset;         // Clock and reset signals
	input  logic gateR, gateL;       // Open/close left and right gates
	input  logic increase, decrease; // Increase/decrease water level
	output logic gondInWater;        // Is gondola in this body of water?
	// Is the gondola in the left or right body of water?
	input  logic gondInR, gondInL;
	
	
	int level;
	
	
	// Set default water level = 0
	initial begin
		level = 0;
		
	end
	
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
	
	// 
	always_ff @(posedge clk) begin
		if (reset) begin
			
		end
		
		end
		
	end
	
	
	
endmodule
