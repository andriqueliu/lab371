// Andrique Liu

// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
   output logic [6:0]     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]	  LEDR;
	input  logic [3:0]     KEY;
	input  logic [9:0]      SW;
	logic 					  A, B;
	
	// Default values, turns off the hex displays
	//               6543210
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// Logic to check if SW[3]..SW[0] match your bottom digit,
	// and SW[7]..SW[4] match the next.
	// Result should drive LEDR[0].
	// SW[3]..SW[0] will match 8: 1 0 0 0
	// SW[7]..SW[4] will match 0: 0 0 0 0
//	assign A = (SW[3] & ~SW[2] & ~SW[1] & ~SW[0]);
//	assign B = ~(SW[7] & SW[6] & SW[5] & SW[4]); 
//	and out(LEDR[0], A, B);

//	assign LEDR[0] = ~SW[7] & ~SW[6] & ~SW[5] & ~SW[4] & SW[3] & ~SW[2] & ~SW[1] & ~SW[0]; // so this definitely works
	assign A = (SW[3] & ~SW[2] & ~SW[1] & ~SW[0]);
	assign B = (~SW[7] & ~SW[6] & ~SW[5] & ~SW[4]); 
	and out(LEDR[0], A, B);
	
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
	// this chunk is what I wrote to replace default... Reverting back to default
//		SW[9] = 1'b0; // Right side means 1 bit... set to 0
//		SW[8] = 1'b0;
//		SW[7] = 1'b0; 
//		SW[6] = 1'b0;
//		SW[5] = 1'b0;
//		SW[4] = 1'b0;
//		SW[3] = 1'b1;
//		SW[2] = 1'b0;
//		SW[1] = 1'b0;
//		SW[0] = 1'b0;
//		#120;
		
		//default
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for (i = 0; i < 256; i++) begin
			SW[7:0] = i; #10;
		end
	end
endmodule 

// warnings are they useless?
// also, isn't the time delay necessary? clarify what "shouldn't go into the testbench"