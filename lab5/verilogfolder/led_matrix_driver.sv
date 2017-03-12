// Sample code
// Used with permission from the UW Department of Electrical Engineering
// Scott Hauck

// Drives the LED array
// Iterates; drives one row active at a time
module led_matrix_driver (clk, red_array, green_array, red_driver,
								  green_driver, row_sink);
	input            clk;
	input [7:0][7:0] red_array, green_array; // 2 dimensional bus... read L to R
	// example: [15:0][7:0] holds 16 8-bit values 
	
	output reg [7:0] red_driver, green_driver, row_sink;
	
	reg [2:0] count; // 3-bit register 
	
	always @(posedge clk)
		count <= count + 3'b001;
	
	always @(*)
		case (count)
			// decoder... outputs binary pattern to control ROWS/SINKS
			3'b000: row_sink = 8'b11111110;   // top of the grid
			3'b001: row_sink = 8'b11111101;
			3'b010: row_sink = 8'b11111011;
			3'b011: row_sink = 8'b11110111;
			3'b100: row_sink = 8'b11101111;
			3'b101: row_sink = 8'b11011111;
			3'b110: row_sink = 8'b10111111;
			3'b111: row_sink = 8'b01111111;   // bottom of the grid 
		endcase
	assign red_driver = red_array[count];
	assign green_driver = green_array[count];
endmodule
