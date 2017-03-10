/*
EE 371 Final Project
2-Player Connect Four

Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

grid 

Orientation: "6" refers to the leftmost, "0" refers to the rightmost
Dimensions: 6 rows x 7 columns
*/
module grid (clk, reset, enter, drop_red, drop_green, red_on, green_on);
	input  logic clk, reset; // Clock, Reset signals
	input  logic enter;      // User input: enter command (OBSOLETE IN THIS MODULE)
	// Command signals; drop a red or green disc into the respective column
	input  logic [6:0] drop_red, drop_green;
	
	// Indicates whether a node is active, and what color it is
	output logic [5:0][7:0] red_on, green_on;
	
	// 7 6-bit registers: models a column of height 6
	logic  [6:0][5:0] red_col, green_col;
	
	// Iterator integers:
	// a is used for the outer loop (6 rows)
	// b is used for the inner loop (7 columns)
	integer  a, b, itr;
	
	// Combinational Logic
	always_comb begin
		// Assign row elements to column elements
		for (a = 0; a < 6; a++) begin
			for (b = 6; b > -1; b--) begin
				red_on[a][b] = red_col[b][a];
				green_on[a][b] = green_col[b][a];
			end
		end
		
		// Fill up the leftmost column with 0s.
		// !!! Note that without this step, the stacking occurs diagonally???
		for (itr = 0; itr < 6; itr++) begin
			red_on[itr][7] = 0;
			green_on[itr][7] = 0;
		end
	end
	
	// Column 6 is the leftmost, Column 0 is the rightmost
	column_manager col6 (.clk, .reset, .drop_red(drop_red[6]), .drop_green(drop_green[6]),
	                     .red_on(red_col[6]), .green_on(green_col[6]));
	column_manager col5 (.clk, .reset, .drop_red(drop_red[5]), .drop_green(drop_green[5]),
	                     .red_on(red_col[5]), .green_on(green_col[5]));
	column_manager col4 (.clk, .reset, .drop_red(drop_red[4]), .drop_green(drop_green[4]),
	                     .red_on(red_col[4]), .green_on(green_col[4]));
	column_manager col3 (.clk, .reset, .drop_red(drop_red[3]), .drop_green(drop_green[3]),
	                     .red_on(red_col[3]), .green_on(green_col[3]));
	column_manager col2 (.clk, .reset, .drop_red(drop_red[2]), .drop_green(drop_green[2]),
	                     .red_on(red_col[2]), .green_on(green_col[2]));
	column_manager col1 (.clk, .reset, .drop_red(drop_red[1]), .drop_green(drop_green[1]),
	                     .red_on(red_col[1]), .green_on(green_col[1]));
	column_manager col0 (.clk, .reset, .drop_red(drop_red[0]), .drop_green(drop_green[0]),
	                     .red_on(red_col[0]), .green_on(green_col[0]));
	
endmodule
