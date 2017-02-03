/*




*/
module transferProcess (clk, reset, timerStart, timerComplete);
	input  logic clk, reset;
	input  logic timerStart;
	
	output logic timerComplete;
	
	integer count;
	
	// Initial Logic
	// 
	initial begin
		
	end
	
	// Combinational Logic
	// 
	always_comb begin
		
	end
	
	// Sequential Logic
	// 
	always_ff @(posedge clk) begin
		if (reset) begin
			count <= -1;
		end
	end
	
endmodule
