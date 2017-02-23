// Andrique Liu

// LFSR outputting 10 bits
// Outputs 7 and 10 are tapped
module lfsr10b (clk, reset, out);
	input  logic       clk, reset;
	output logic [9:0] out;
	
	logic dff1out, dff2out, dff3out, dff4out, dff5out;
	logic dff6out, dff7out, dff8out, dff9out, dff10out;
	
	logic xnorout;
	xnor  xnorgate (xnorout, dff7out, dff10out);
	
	dflipflop dff1 (.clk, .reset, .d(xnorout), .q(dff1out));
	dflipflop dff2 (.clk, .reset, .d(dff1out), .q(dff2out));
	dflipflop dff3 (.clk, .reset, .d(dff2out), .q(dff3out));
	dflipflop dff4 (.clk, .reset, .d(dff3out), .q(dff4out));
	dflipflop dff5 (.clk, .reset, .d(dff4out), .q(dff5out));
	dflipflop dff6 (.clk, .reset, .d(dff5out), .q(dff6out));
	dflipflop dff7 (.clk, .reset, .d(dff6out), .q(dff7out));
	dflipflop dff8 (.clk, .reset, .d(dff7out), .q(dff8out));
	dflipflop dff9 (.clk, .reset, .d(dff8out), .q(dff9out));
	dflipflop dff10 (.clk, .reset, .d(dff9out), .q(dff10out));
	
	assign out[9] = dff1out;
	assign out[8] = dff2out;
	assign out[7] = dff3out;
	assign out[6] = dff4out;
	assign out[5] = dff5out;
	assign out[4] = dff6out;
	assign out[3] = dff7out;
	assign out[2] = dff8out;
	assign out[1] = dff9out;
	assign out[0] = dff10out;
//	dflipflop dff1 (.clk, .reset, .d(xnorout), .q(q1));
//	dflipflop dff2 (.clk, .reset, .d(dff1out), .q(q2));
//	dflipflop dff3 (.clk, .reset, .d(dff2out), .q(q3)); // ...
	
	// !!!!!!!!!! Weird, switching from the output logic method to the 
	// plain logic method makes it work...
	
//	// DFFs
//	always_ff @(posedge clk)
//		if (reset)
//			q <= 0;   // Resets to 0
//		else
//			q <= d;   // Otherwise, output = d
			
endmodule

module lfsr10b_testbench();
	logic       clk, reset;
	logic [9:0] out;
	
	lfsr10b dut (clk, reset, out);
	
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