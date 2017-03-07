/*




*/
module native_board_input (clk, reset, column, enter, column_select);
	input  logic clk, reset;
	input  logic [6:0] column;
	input  logic enter;
	
	output logic [6:0] column_select;
	
	logic  press;
	
	uinput debounce (.clk, .reset, .in(enter), .out(press));
	
	always_comb begin
		if (press) begin
			column_select = column;
		end else begin
			column_select = {7{1'b0}};
		end
	end
	
	
//	always_ff @(posedge clk) begin
//		if (reset) begin
//			press <= 0;
//		end
//	end
	
endmodule

// Tester Module
module native_board_input_testbench();
	logic clk, reset;
	logic [6:0] column;
	logic enter;
	
	logic [6:0] column_select;
	
	native_board_input dut (clk, reset, column, enter, column_select);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	enter <= 0;            @(posedge clk);
	reset <= 1; 			  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
	column <= 7'b0001000; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	enter <= 1;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	enter <= 0;            @(posedge clk);
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	enter <= 1;            repeat (20) @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
