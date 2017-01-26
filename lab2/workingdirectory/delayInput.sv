/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

delayInput serves to delay the user's input. The user's input to this module
starts a timer, after which delayInput will output an enable signal.

Note: A "minute" will count as half a second in real life.

// This is an example of parameterized modules, just for reference
module adder #(parameter WIDTH=5) (out, a, b);
	output logic [WIDTH-1:0] out;
	input logic [WIDTH-1:0] a, b;
	assign out = a + b;
endmodule
//
// 
//
// A 16-bit adder
adder #(.WIDTH(16)) add1 (.out(o1), .a(a1), .b(b1));
// A default-width adder, so 5-bit (WIDTH parameter not changed, so it goes to
// default.
adder add2 (.out(o2), .a(a2), .b(b2));
*/

//module delayInput #(parameter MINUTES = 1)
//                  #(parameter CLOCK = 50000000) // 50 MHz default
//                   (clk, reset, start, enable);
module delayInput #(parameter MINUTES = 1, CLOCK = 50000000)
                   (clk, reset, start, enable);
	input  logic clk, reset; // Clock, reset signals
	input  logic start;
	output logic enable;
	
	int count;
	
	initial begin
		count = -1;
	end
	
	// Combinational Logic
	// A "minute" in design time is a half second in real time
	// Once count counts specified number of ticks, enable is sent
	always_comb begin
		if (count == (CLOCK * MINUTES / 2)) begin
			enable = 1;
		end else begin
			enable = 0;
		end
	end
	
	// Sequential Logic
	// Note: count is "dormant" or disabled at -1, but continues to increment
	// at values of 0 and greater, until specified ticks are reached.
	//
	// If reset or if count counts specified number of ticks, then count
	// goes to dormant value -1.
	// Else if start is set and count is dormant at -1, begin count at 0.
	// Else if count is at active value, increment count.
	always_ff @(posedge clk) begin
		if (reset || (count == (CLOCK * MINUTES / 2))) begin
			count <= -1;
		end else if (start && (count == -1)) begin
			count <= 0;
		end else if (count >= 0) begin
			count <= count + 1;
		end
	end
	
endmodule
