/*




*/
module serial_tester (clk, reset, column, enter);
	input  logic clk, reset;
	input  logic [6:0] column;
	input  logic enter;
	
	logic  clk_pipe, bit_pipe;
	
	serial_out ser_out (.clk, .reset, .ready_in( ), .column, .enter,
	                    .clk_out(clk_pipe), .bit_out(bit_pipe));
	
	serial_in ser_in (.clk, .reset, .clk_in(clk_pipe), .bit_in(bit_pipe),
	                  .column_select( ));
	
	
endmodule

// Tester Module
module serial_tester_testbench();
	logic clk, reset;
	logic [6:0] column;
	logic enter;
	
	serial_tester dut (clk, reset, column, enter);
	
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
//	column <= 7'b0001000;  @(posedge clk);
	column <= 7'b1000000;  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
	repeat (6) @(posedge clk);
//repeat (20) @(posedge clk);
								  @(posedge clk);
//	enter <= 1;            @(posedge clk);
//	enter <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	column <= 7'b0100000;  @(posedge clk);
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	column <= 7'b0010000;  @(posedge clk);
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
	repeat (12) @(posedge clk);
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
	repeat (6) @(posedge clk);
	column <= 7'b0000010;
	enter <= 1;            @(posedge clk);
	enter <= 0;            @(posedge clk);
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
