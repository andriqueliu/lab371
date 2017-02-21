// Andrique Liu

// Copy of lab3
module lab3 (LEDR, SW);
	output logic [9:0]	  LEDR;
	input  logic [9:0]      SW;
	logic 					  A, B;
	
	// Lab logic
	// Use SW 9, 8, and 7 for U, P, and C, respectively
	// Use SW 0 for the secret Mark
	// Use LEDR 1 and 0 for Discounted and Stolen, respectively
	assign LEDR[1] = SW[8] | (SW[9] & SW[7]); // Discounted

	assign A = (~SW[8] & ~SW[7] & ~SW[0]);
	assign B = (SW[9] & ~SW[8] & ~SW[0]);
	assign LEDR[0] = A | B; // Stolen
endmodule 

module lab3_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Take out input/output "tags"
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	lab3 dut (.LEDR, .SW);
	
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