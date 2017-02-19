// Andrique Liu

// Simple DFF FSM
module comptest (clk, reset, out);
	input logic       clk, reset;
	output logic out;
	
	logic [9:0] a, b;
//	assign a[9:0] = 10'b0100000000;
	assign a[9:0] = 10'b0001000010; // guess it does work?
	assign b[9:0] = 10'b0001000010;
	
	logic a_g_b;
	
	comparator comp (.clk, .reset, .a, .b, .a_g_b);
	
	assign out = a_g_b;
	
endmodule

module comptest_testbench();
	logic clk, reset;
	logic out;
	
	comptest dut (clk, reset, out);
	
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