/*



Note: Default setting outputs an enable signal every second, assuming
main clock signal is 25 MHz.
*/
module timer #(parameter DELAY=25000000) (clk, reset, enable);
	input  logic clk, reset;
	
	output logic enable;
	
	integer ctr;
	
	// Initial Logic
	// 
	initial begin
		ctr = 0;
	end
	
	// Combinational Logic
	// 
	always_comb begin
		if (ctr == (DELAY - 1)) begin
			enable = 1;
		end else begin
			enable = 0;
		end
	end
	
	// Sequential Logic
	// 
	always_ff @(posedge clk) begin
		if (reset || (ctr == (DELAY - 1))) begin
			ctr <= 0;
		end else begin
			ctr <= ctr + 1;
		end
	end
	
endmodule

// Tester Module
module timer_testbench();
	logic clk, reset;
	logic enable;
	
	timer #(.DELAY(8)) dut (clk, reset, enable);
	
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
