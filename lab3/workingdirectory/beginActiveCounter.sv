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
//		if (count == (25000000 - 1)) begin
		if (count == (8 - 1)) begin
			startActive = 1;
		end else begin
			startActive = 0;
		end
	end
	
	// Sequential Logic
	// At reset, count goes to inactive state.
	// When count is inactive and module receives startStandby signal, begin counting.
	// While count is active and is still below max, keep incrementing.
	always_ff @(posedge clk) begin
//		if (reset || (count == (25000000 - 1))) begin
		if (reset || (count == (8 - 1))) begin
			count <= -1;
		end else if ((count == -1) && startStandby) begin
			count <= 0;
//		end else if ((count >= 0) && (count < (25000000 - 1))) begin
		end else if ((count >= 0) && (count < (8 - 1))) begin
			count <= count + 1;
		end
	end
	
endmodule

// Test module
module beginActiveCounter_testbench();
	logic clk, reset;   // Clock, Reset
	logic startStandby; // Start STANDBY state
	
	logic startActive;  // Start ACTIVE state
	
	beginActiveCounter dut (clk, reset, startStandby, startActive);
	
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
	startStandby <= 1;      @(posedge clk);
	startStandby <= 0;      @(posedge clk);
	repeat (10) @(posedge clk);
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
