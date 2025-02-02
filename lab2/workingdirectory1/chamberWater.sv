/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

chamberWater tracks the chamber's water level. This module also sends outputs which
indicate whether water differentials are good to pass. 

This module keeps track of an int that represents the current water level.

Left body of water is at +3 feet relative to chamber default.
Right body of water is at -3 feet relative to chamber default.

Note: this module multiplies typical values by 2; "real" values like floats are
not supported in Quartus.
*/
module chamberWater (clk, reset, increase, decrease, rightGood, leftGood);
	input  logic clk, reset;          // Clock and reset signals
	input  logic increase, decrease;  // Increase/decrease water level	
	// Are the right/left water differentials even?
	// This allows/disallows gates to be opened
	output logic rightGood, leftGood;
	
	int level;
	
	// Set default water level = 0
	initial begin
		level = 0;	
	end
	
	// Combinational Logic
	always_comb begin
		if (level == 6) begin
			leftGood  = 1;
			rightGood = 0;
		end else if (level == -6) begin
//		end else if (level == 0) begin
			leftGood  = 0;
//			leftGood = 1;
			rightGood = 1;
		end else begin
			leftGood  = 0;
			rightGood = 0;
		end
	end
	
	// Sequential logic
	always_ff @(posedge clk) begin
		if (reset) begin
			level <= 0;
		end else if (increase && (level <= 9)) begin
			level <= level + 1;
		end else if (decrease && (level >= -9)) begin
			level <= level - 1;
		end
	end
	
endmodule

module chamberWater_testbench();
	logic clk, reset;          // Clock and reset signals
	logic increase, decrease;  // Increase/decrease water level	
	// Are the right/left water differentials even? (Can gate be opened)
	logic rightGood, leftGood;
//	int levelTest;
	
	chamberWater dut (clk, reset, increase, decrease, rightGood, leftGood);
	
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
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk); // 5
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk); // 9
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk); // 10
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk);
								  @(posedge clk);
	increase <= 1;         @(posedge clk);
	increase <= 0;         @(posedge clk); // "12"
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
