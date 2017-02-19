// Andrique Liu

// Compares 10-bit values
// Returns true if a > b, false otherwise
module comparator (clk, reset, a, b, a_g_b);
	input logic       clk, reset;
	input logic [9:0] a, b;
	
	output logic a_g_b;
	
	assign a_g_b = (a > b);
	
endmodule

module comparator_testbench();
	logic clk, reset;
	logic [9:0] a, b;
	logic a_g_b;
	
	comparator dut (clk, reset, a, b, a_g_b);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);		// !!! you wait for a posedge (and thus FSM)
	reset <= 1; 			  @(posedge clk);		// moves to the next state) before applying
	reset <= 0;            @(posedge clk);		// new inputs
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	a[9:0] <= 10'b0100000000;			@(posedge clk);
	b[9:0] <= 10'b0100000000;			@(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	a[9:0] <= 10'b0100000000;			@(posedge clk);
	b[9:0] <= 10'b0000000000;			@(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
//	d <= 0;					  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	d <= 1;					  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	d <= 0;					  @(posedge clk);
//	d <= 1;					  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule