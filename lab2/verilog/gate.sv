// EE 371 Lab 2 Project
// gate is a lower level module that dictates whether a gondola may cross

//Should an output be added that tells you if the water levels are good?
//like indicated in the rightWater module?
module gate(clk, reset, leftLevel, rightLevel, open);
	
	input logic clk, reset;
	input logic leftLevel, rightLevel;
	output logic open;

	logic diff = leftLevel - rightLevel; //Not sure if this is correct. I actually
						//want to take the absolute value

	//State variables
	enum {OPEN, CLOSE}, ps, ns;

	always_comb begin
		case (ps)
		
		OPEN:
			if(diff > 0.3) begin
				ns = CLOSE;
				open = 0;
			end else begin
				ns = OPEN;
				open = 1;
			end
		CLOSE:
			if(diff > 0.3) begin
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
