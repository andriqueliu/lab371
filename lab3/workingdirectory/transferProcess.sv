/*



Note: Transfer and Flush processes should take half as long as it takes to 
fill the buffer. 
*/
module transferProcess (clk, reset, timerStart, timerComplete);
	input  logic clk, reset;
	input  logic timerStart;
	
	output logic timerComplete;
	
	integer count;
	
	// Initial Logic
	// 
	initial begin
		count = -1;
	end
	
	// Combinational Logic
	// 
	always_comb begin
		if (count == (8 - 1)) begin
			timerComplete = 1;
		end else begin
			timerComplete = 0;
		end
	end
	
	// Sequential Logic
	// 
	always_ff @(posedge clk) begin
		if (reset || (count == (8 - 1))) begin
			count <= -1;
		end else if ((count == -1) && timerStart) begin
			count <= 0;
		end else if ((count >= 0) && (count < (8 - 1))) begin
			count <= count + 1;
		end
	end
	
endmodule

// Test module
module transferProcess_testbench();
	logic clk, reset;
	logic timerStart;
	
	logic timerComplete;
	
	transferProcess dut (clk, reset, timerStart, timerComplete);
	
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
								  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	repeat (20) @(posedge clk);
	timerStart <= 1;     @(posedge clk);
	timerStart <= 0;     @(posedge clk);
	repeat (10) @(posedge clk);
	timerStart <= 1;     @(posedge clk);
	timerStart <= 0;     @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
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
