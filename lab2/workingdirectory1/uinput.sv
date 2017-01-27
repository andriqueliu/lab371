// Andrique Liu

// Simple state machine: one input, one output.
// Detects user input.
// Detect the moment a button is pressed... output is TRUE for only
// one cycle for every button press.
// This FSM handles all user input.

// Puts signals through pairs of DFFs for metastability.
module uinput (clk, reset, in, out);
	input logic clk, reset, in;
	output logic out;
	
	// Declare intermediate variables
	logic middle, last;
	
	// Put key inputs through pairs of dffs
	dflipflop d1 (.clk, .reset, .d(in), .q(middle));
	dflipflop d2 (.clk, .reset, .d(middle), .q(last));
	
	// State variables
	enum { N, P } ps, ns;
	
	// Combinational logic
	always_comb begin
		case(ps)
			N: if (last) begin
					ns = P;
					out = 1;
				end else begin
					ns = N;
					out = 0;
				end
			P:	if (last) begin
					ns = P;
					out = 0;
				end else begin
					ns = N;
					out = 0;
				end
		endcase
	end
	
	// Sequential logic at every posedge clk
	always_ff @(posedge clk)
		if (reset)
			ps <= N;  // at reset, go back to None
		else
			ps <= ns; // otherwise, go to the next state, dictated by NS logic

endmodule

module uinput_testbench();
	logic clk, reset, in;
	logic out;
	
	uinput dut (clk, reset, in, out);
	
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
	reset <= 0; in <= 0;   @(posedge clk);		// new inputs
//reset <= 0;   @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
					  in <= 1; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
					  in <= 0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
					  in <= 1; @(posedge clk);
					  in <= 0; @(posedge clk);
					  in <= 1; @(posedge clk);
					  in <= 0; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule