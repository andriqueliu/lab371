/*




*/
module serial_in (clk, reset, clk_in, bit_in, column_select, constant_col_sel, three_in);
	input  logic clk, reset;
	input  logic clk_in, bit_in;
	
	output logic [6:0] column_select;
	output logic [6:0] constant_col_sel;
	output logic three_in;
	
	logic  [6:0] local_column_select;
	logic  [2:0] local_binary_data;
	
	logic  match;
	
	assign constant_col_sel = local_column_select;
	
	integer i, prev_i;
	
	initial begin
		local_binary_data = {3{1'b0}};
		match = 0;
		i = 0;
	end
	
	decoder dec (.clk, .reset, .binary_data(local_binary_data),
	             .decoded_data(local_column_select));
	
	enum { WAIT, SEND } ps, ns;
	
	// 
	always_comb begin
		case (ps)
			WAIT: begin
				if (((prev_i + 1) % 3 == 0) && (i % 3 == 0) && (i != 0 && prev_i != 0)) begin
					ns = SEND;
					column_select = local_column_select;
					three_in = 1;
				end else begin
					ns = WAIT;
					column_select = 7'b0000000;
					three_in = 0;
				end
			end
			
			SEND: begin
				if (i % 3 == 0) begin
					ns = SEND;
				end else begin
					ns = WAIT;
				end
				column_select = 7'b0000000;
				three_in = 0;
			end
		endcase
		
	end
	
	// 
	always_ff @(posedge clk_in or posedge reset) begin
		if (reset) begin
			local_binary_data <= {3{1'b0}};
			i <= 0;
		end else begin
			local_binary_data[i % 3] <= bit_in;
			i <= i + 1;
		end
	end
	
	// 
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= WAIT;
		end else begin
			ps <= ns;
		end
		
		prev_i <= i;
	end
	
endmodule

//// Tester Module
//module serial_in_testbench();
//	logic clk, reset;
//	logic clk_in, bit_in;
//	
//	logic [6:0] column_select;
//	
//	serial_in dut (clk, reset, clk_in, bit_in, column_select);
//	
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	initial begin
//								  @(posedge clk);
//								  @(posedge clk);
//	reset <= 1;            @(posedge clk);
//	reset <= 0;            @(posedge clk);
//								  @(posedge clk);
//	clk_in <= 1; bit_in <= 1; @(posedge clk);
//	clk_in <= 0; @(posedge clk);
//
//	bit_in <= 0; clk_in <= 1; @(posedge clk);
//	clk_in <= 0; @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	$stop; // End the simulation.
//	end
//endmodule
