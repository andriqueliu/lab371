// EE 371 Lab 2 Project
// gate is a lower level module that dictates whether a gondola may cross

//Should an output be added that tells you if the water levels are good?
//like indicated in the rightWater module?
module gate(clk, reset, openCase, open);
	
	input logic clk, reset;
	input logic openCase;
	output logic open;

	//State variables
	enum {OPEN, CLOSE}, ps, ns;

	always_comb begin
		case (ps)
		
		OPEN:
			if(!openCase) begin
				ns = CLOSE;
				open = 0;
			end else begin
				ns = OPEN;
				open = 1;
			end
		CLOSE:
			if(!openCase) begin
				ns = CLOSE;
				open = 0;
			end else begin
				ns = OPEN;
				open = 1;
			end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset)
			ps <= CLOSE; //reset as closed
		else
			ps <= ns;
	end
endmodule
