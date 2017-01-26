/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

delayInput serves to delay the user's input. The user's input to this module
starts a timer, after which delayInput will output an enable signal.

delayInput also uses a busy flag output to tell external modules whether a count
process is currently active. That way, other tasks must be disregarded until the
count process is complete. This avoids race conditions, signals catching up to
each other, etc.

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
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
// Using smaller tick requirements for testing
module delayInput #(parameter MINUTES = 1, CLOCK = 25000000)
//module delayInput #(parameter MINUTES = 1, CLOCK = 50000000)
                   (clk, reset, start, enable, busy);
	input  logic clk, reset; // Clock, reset signals
	input  logic start;      // Input signal; start timer to enable
	output logic enable;     // Enable signal; set after specified ticks elapsed
	// Tells external module whether count process is active. If count process
	// is active, do not allow other inputs at the same time.
	output logic busy;
	
	int count;
	
	initial begin
		count = -1;
	end
	
	// Combinational Logic
	// A "minute" in design time is a half second in real time
	always_comb begin
		// Once count counts specified number of ticks, enable is sent
		if (count == (CLOCK * MINUTES / 2)) begin
			enable = 1;
		end else begin
			enable = 0;
		end
		
		// If count is active, set busy flag. Else, clear busy flag.
		if (count >= 0) begin
			busy = 1;
		end else begin
			busy = 0;
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

module delayInput_testbench();
	logic clk, reset; // Clock, reset signals
	logic start;
	logic enable;
	logic busy;
	
	delayInput dut (clk, reset, start, enable, busy);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	reset <= 1; 			  @(posedge clk);
								  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
	start <= 1;				  @(posedge clk);
	start <= 0;				  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  repeat (20) @(posedge clk);
	start <= 1;            @(posedge clk);
								  @(posedge clk);
								  repeat (30) @(posedge clk);
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
