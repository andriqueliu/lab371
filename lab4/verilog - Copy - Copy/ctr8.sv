// !!!!!!!!!!
// WAIT... incr. to 7 shouldn't be a big deal... 
// the driver is incr. to 7 as well... 

// generates an enable after 7 cycles
module ctr8 (clk, reset, enable);
	input  logic clk, reset;
	output logic enable;
	
//   logic [2:0] register;
//	
//	// trying out an always_comb block
//	always_comb begin
//		if (register == 3'b111)
//			enable = 1;
//		else 
//			enable = 0;
//	end
//	
//	always_ff @(posedge clk)
//		if (reset)
//			register <= 3'b000;
//		else 
//			register <= register + 3'b001;

	int ct;
	
	// 
	always_comb begin
		if (ct == 7)   // it works!
			enable = 1;
		else 
			enable = 0;
	end
	
	always_ff @(posedge clk)
		if (reset || (ct == 7))
			ct <= 0;
		else 
			ct <= ct + 1; 

//   logic [3:0] register;
//	
//	// trying out an always_comb block
//	always_comb begin
//		if (register == 4'b1000)
//			enable = 1;
//		else 
//			enable = 0;
//	end
//	
//	always_ff @(posedge clk)
//		if (reset || (register == 4'b1000))
//			register <= 4'b0000;
//		else 
//			register <= register + 4'b0001;

//	
//	// do you need register? Or can you incr. an output logic 
//	always_ff @(posedge clk)
//		if (reset)
//			out <= 3'b000;
//		else 
//			out <= out+ 3'b0001;
//	
//	// so both the register and the out methods work...

endmodule 

module ctr8_testbench();
	logic clk, reset;
	logic enable;
	
	ctr8 dut (clk, reset, enable);
	
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
								  @(posedge clk);
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
	$stop; // End the simulation.
	end
endmodule
