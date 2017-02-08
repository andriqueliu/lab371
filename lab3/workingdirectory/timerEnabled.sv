/*



Note: Default setting outputs an enable signal every second, assuming
main clock signal is 25 MHz.
*/
module timerEnabled #(parameter DELAY=25000000) (clk, reset, beginTimer, enable);
	input  logic clk, reset;
	input  logic beginTimer;
	
	output logic enable;
	
	integer ctr;
	
	// Initial Logic
	// 
	initial begin
		ctr = -1;
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
		if (reset) begin
			ctr <= -1;
		end else if ((ctr == -1 && beginTimer) || ctr == (DELAY - 1)) begin
			ctr <= 0;
		end else if (ctr >= 0) begin
			ctr <= ctr + 1;
		end
	end
	
endmodule

// Tester Module
module timerEnabled_testbench();
	logic clk, reset;
	logic beginTimer;
	logic enable;
	
	timerEnabled #(.DELAY(8)) dut (clk, reset, beginTimer, enable);
	
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
	beginTimer <= 1;       @(posedge clk);
	beginTimer <= 0;       @(posedge clk);
								  @(posedge clk);
	repeat (20) @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	beginTimer <= 1;       @(posedge clk);
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
