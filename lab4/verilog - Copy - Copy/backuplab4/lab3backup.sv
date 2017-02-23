// Andrique Liu

// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
   output logic [6:0]     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]	  LEDR;
	input  logic [3:0]     KEY;
	input  logic [9:0]      SW;
	logic 					  A, B; // Change this part as needed
	
	// Default values, turns off the hex displays
	//               6543210
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// Lab logic
	// Use SW 9, 8, and 7 for U, P, and C, respectively
	// Use SW 0 for the secret Mark
	// Use LEDR 1 and 0 for Discounted and Stolen, respectively
	// ??? Can you assign more convenient names?
	assign LEDR[1] = SW[8] | (SW[9] & SW[7]); // Discounted

	assign A = (~SW[8] & ~SW[7] & ~SW[0]);
	assign B = (SW[9] & ~SW[8] & ~SW[0]);
	assign LEDR[0] = A | B; // Stolen
	
endmodule 

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Take out input/output "tags"
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
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