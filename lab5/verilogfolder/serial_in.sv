/*




*/
module serial_in (clk, reset, clk_in, bit_in, column_select);
	input  logic clk, reset;
	input  logic clk_in, bit_in;
	
	output logic [6:0] column_select;
	
	logic  [6:0] local_column_select;
	logic  [2:0] local_binary_data;
	
	logic  match;
	
	integer i;
	
	initial begin
		local_binary_data = {3{1'b0}};
		match = 0;
		i = 0;
	end
	
	
	decoder dec (.clk, .reset, .binary_data(local_binary_data),
	             .decoded_data(local_column_select));
	
	always_comb begin
		if (match) begin
			column_select = local_column_select;
		end else begin
			column_select = {7{1'b0}};
		end
	end
	
	// 
//	always_ff @(posedge clk) begin
//		if (reset) begin
//			local_binary_data <= {3{1'b0}};
//			i <= 0;
//		end
////		end else if (i == 3) begin
////			i <= 0;
////		end
//	end
//	
//	always_ff @(negedge clk) begin
//		if (i == 3) begin
//			i <= 0;
//		end
//	end
//	
//	// 
//	always_ff @(negedge clk_in) begin
//			local_binary_data[i] <= bit_in;
//			i <= i + 1;
//	end

	always_ff @(posedge clk) begin
		if (reset) begin
			local_binary_data <= {3{1'b0}};
			i <= 0;
			match <= 0;
		end else if (i == 3) begin
			match <= 1;
			i <= 4;
		end else if (i == 4) begin
			i <= 0;
			match <= 0;
		end
	end
	
	// 
	always_ff @(negedge clk_in) begin
		local_binary_data[i] <= bit_in;
		i <= i + 1;
	end
	
endmodule

// Tester Module
module serial_in_testbench();
	logic clk, reset;
	logic clk_in, bit_in;
	
	logic [6:0] column_select;
	
	serial_in dut (clk, reset, clk_in, bit_in, column_select);
	
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
	clk_in <= 1; bit_in <= 1; @(posedge clk);
	clk_in <= 0; @(posedge clk);

	bit_in <= 0; clk_in <= 1; @(posedge clk);
	clk_in <= 0; @(posedge clk);
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
