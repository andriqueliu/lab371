// Andrique Liu

// Simple DFF FSM
module dflipflop (clk, reset, d, q);
	input logic clk, reset, d;
	output logic q;

	// DFFs
	always_ff @(posedge clk)
		if (reset)
			q <= 0;   // Resets to 0
		else
			q <= d;   // Otherwise, output = d
			
endmodule

module dflipflop_testbench();
	logic clk, reset;
	logic d, q;
	
	dflipflop dut (clk, reset, d, q);
	
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
	d <= 0;					  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d <= 1;					  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	d <= 0;					  @(posedge clk);
	d <= 1;					  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule