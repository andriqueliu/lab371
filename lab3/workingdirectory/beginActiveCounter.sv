/*




*/
module beginActiveCounter (clk, reset, startStandby, startActive);
	input  logic clk, reset;   // Clock, Reset
	input  logic startStandby; // Start STANDBY state
	
	output logic startActive;  // Start ACTIVE state
	
	integer count; // Counter; increments across clock cycles
	
	// Initial Logic
	// Set count to inactive state.
	initial begin
		count = -1;
	end
	
	// Combinational Logic
	// Indicate to start ACTIVE state after desired clock cycles have
	// passed (HIGH output). Else, output LOW.
	always_comb begin
		if (count == (25000000 - 1)) begin
			beginActive = 1;
		end else begin
			beginActive = 0;
		end
	end
	
	// Sequential Logic
	// At reset, count goes to inactive state.
	// When count is inactive and module receives startStandby signal, begin counting.
	// While count is active and is still below max, keep incrementing.
	always_ff @(posedge clk) begin
		if (reset) begin
			count <= -1;
		end else if ((count == -1) && startStandby) begin
			count <= 0;
		end else if ((count >= 0) && (count < (25000000 - 1))) begin
			count <= count + 1;
		end
	end
	
endmodule
