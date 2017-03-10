/*
EE 371 Final Project
2-Player Connect Four

Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

legality_checker performs checks on whether a move can be made or not.
If a move is legal, then the enter command functions as normal. If a move is illegal,
then enter simply goes to 0 and the player must try a legal move before progressing
the game state.
*/
module legality_checker (clk, reset, enter_input, column_select, enter_output);
	input  logic clk, reset;
	input  logic enter_input;
	input  logic [6:0] column_select;
	
	output logic enter_output;
	
	// Boolean variables
	logic  no_bits_set, one_bit_set;
	// True only if no bits are set
	assign no_bits_set = (column_select == {7{1'b0}});
	// True if only one bit is set AND at least one bit is set
	assign one_bit_set = ((column_select == (column_select & -column_select)) && (!no_bits_set));
	
	// 
	always_comb begin
		if (one_bit_set) begin
			enter_output = enter_input;
		end else begin
			enter_output = 0;
		end
	end
	
endmodule

// Tester Module
module legality_checker_testbench();
	logic clk, reset;
	logic enter_input;
	logic [6:0] column_select;
	
	logic enter_output;
	
	legality_checker dut (clk, reset, enter_input, column_select, enter_output);
	
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
	column_select <= 7'b0000000; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	column_select <= 7'b0100000; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	column_select <= 7'b0000101; @(posedge clk);
	column_select <= 7'b0010101; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	column_select <= 7'b0000000; @(posedge clk);
	column_select <= 7'b0000001; @(posedge clk);
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
