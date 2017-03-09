///*
//
//
//
//Dimensions: 6 rows x 7 columns
//*/
//module grid (clk, reset, enter, test_enter, drop_red, drop_green);
//	input  logic clk, reset;
//	input  logic enter;
//	input  logic test_enter;
//	input  logic [6:0] drop_red, drop_green;
//	
//	output logic [5:0][6:0] 
//	
//	// Column 6 is the leftmost, Column 0 is the rightmost
//	column_manager col6 (.clk, .reset, .drop_red(drop_red[6]), .drop_green(drop_green[6]),
//	                     .red_on({  }),
//								.green_on({  }));
//	column_manager col5 (.clk, .reset, .drop_red(drop_red[5]), .drop_green(drop_green[5]),
//	                     .red_on(), .green_on());
//	column_manager col4 (.clk, .reset, .drop_red(drop_red[4]), .drop_green(drop_green[4]),
//	                     .red_on(), .green_on());
//	column_manager col3 (.clk, .reset, .drop_red(drop_red[3]), .drop_green(drop_green[3]),
//	                     .red_on(), .green_on());
//	column_manager col2 (.clk, .reset, .drop_red(drop_red[2]), .drop_green(drop_green[2]),
//	                     .red_on(), .green_on());
//	column_manager col1 (.clk, .reset, .drop_red(drop_red[1]), .drop_green(drop_green[1]),
//	                     .red_on(), .green_on());
//	column_manager col0 (.clk, .reset, .drop_red(drop_red[0]), .drop_green(drop_green[0]),
//	                     .red_on(), .green_on());
//	
////	always_comb begin
////		if () begin
////			
////		end else begin
////			
////		end
////	end
//	
//	
//	
//endmodule
