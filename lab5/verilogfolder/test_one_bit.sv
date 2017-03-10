/*




*/
module test_one_bit (clk, reset, tester, bool);
	input  logic clk, reset;
	input  logic [5:0] tester;
	
	output logic bool;
	
	always_comb begin
		if (tester == (tester & -tester)) begin
			bool = 1;
		end else begin
			bool = 0;
		end
	end
	
endmodule

// Tester Module
module test_one_bit_testbench();
	logic clk, reset;
	logic [5:0] tester;
	logic bool;
	
	test_one_bit dut (clk, reset, tester, bool);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
								  @(posedge clk);
	reset <= 1;            @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
	tester <= 6'b000001;   @(posedge clk);
								  @(posedge clk);
	tester <= 6'b000010;   @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	tester <= 6'b001000;   @(posedge clk);
	tester <= 6'b000001;   @(posedge clk);
								  @(posedge clk);
	tester <= 6'b010001;   @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	tester <= 6'b000000;   @(posedge clk);
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
