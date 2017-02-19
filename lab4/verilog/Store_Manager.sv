// Andrique Liu

// Top-level module that defines the I/Os for the DE-1 SoC board (Remove)
// Instantiates UPC_Manager to manage hex displays
// Instantiates copy of Lab 3 to manage Discounted and Stolen lights

module Store_Manager (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); // defaults
   output logic [6:0]     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]	  LEDR;
	input  logic [3:0]     KEY;
	input  logic [9:0]     SW;
	logic 					  A, B;
	logic 		 [4:0]	  letter0, letter1, letter2, letter3, letter4, letter5;
	
	// Instantiate UPC_Manager to take care of hex displays 
	// Same names are used in both modules
	// Uses UPC inputs (9, 8, and 7)
	UPC_Manager upcman (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .SW);
	
	// Instantiate copy of Lab 3 to manage two LED lights
	// U, P, C inputs will be SW 9, 8, 7, respectively
	// SW 0 is used for Mark
	// Use LEDR 1 and 0 for Discounted and Stolen, respectively		
	lab3 lab3man (.LEDR, .SW);
	
endmodule 

// Test signals
module Store_Manager_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	Store_Manager dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	// Try all combinations of inputs. 
	integer i;
	initial begin
		SW[6] = 1'b0;
		SW[5] = 1'b0;
		SW[4] = 1'b0;
		SW[3] = 1'b0;
		SW[2] = 1'b0;
		SW[1] = 1'b0;
		for (i = 0; i < 16; i++) begin
			{SW[9], SW[8], SW[7], SW[0]} = i; #10;
		end
	end
endmodule 