// Andrique Liu

// Simple DFF FSM
//module lfsr3b (clk, reset, q1, q2, q3);
module lfsr3b (clk, reset, out);
	input  logic       clk, reset;
//	output logic q1, q2, q3;
	output logic [2:0] out;
	
	logic dff1out, dff2out, dff3out; // helpful...
	logic xnorout;
	xnor  xnorgate (xnorout, dff2out, dff3out);
	
	dflipflop dff1 (.clk, .reset, .d(xnorout), .q(dff1out));
	dflipflop dff2 (.clk, .reset, .d(dff1out), .q(dff2out));
	dflipflop dff3 (.clk, .reset, .d(dff2out), .q(dff3out));

//	assign q1 = dff1out;
//	assign q2 = dff2out;
//	assign q3 = dff3out;
	assign out[2] = dff1out;
	assign out[1] = dff2out;
	assign out[0] = dff3out;
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

module lfsr3b_testbench();
	logic clk, reset;
//	logic q1, q2, q3;
	logic [2:0] out;
	
//	lfsr3b dut (clk, reset, q1, q2, q3);
	lfsr3b dut (clk, reset, out);
	
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