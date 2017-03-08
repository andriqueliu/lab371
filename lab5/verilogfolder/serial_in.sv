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
	
//	local_col_FSM col_fsm (.clk, .reset, .i,
//	                       .column_in(local_column_select), .column_out(column_select));
	
	initial begin
		local_binary_data = {3{1'b0}};
		match = 0;
		i = 0;
	end
	
	decoder dec (.clk, .reset, .binary_data(local_binary_data),
	             .decoded_data(local_column_select));
	
	// 
	always_comb begin
		
		TESTING: column_select = local_column_select;
//		if (match) begin
//			column_select = local_column_select;
//		end else begin
//			column_select = {7{1'b0}};
//		end
//		if ((i % 3) == 1) begin
//			column_select = local_column_select;
//		end else begin
//			column_select = {7{1'b0}};
//		end

//		if ((i % 3) == 0) begin
//			column_select = local_column_select;
//		end else begin
//			column_select = {7{1'b0}};
//		end
	end
	
	always_ff @(posedge clk_in or posedge reset) begin
		if (reset) begin
			local_binary_data <= {3{1'b0}};
			i <= 0;
		end else begin
			local_binary_data[i % 3] <= bit_in;
			i <= i + 1;
		end
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
