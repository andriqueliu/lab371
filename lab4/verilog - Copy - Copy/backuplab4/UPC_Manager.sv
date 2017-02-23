// Andrique Liu

// Top-level module that defines the I/Os for the DE-1 SoC board (Remove)
// This will be isntantiated by a higher-level top module
// Manage SIX hex displays and two LEDRS using 4 switch inputs

module UPC_Manager (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
   output logic [6:0]     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]	  LEDR;
	input  logic [3:0]     KEY;
	input  logic [9:0]     SW;
	logic 					  A, B; // Change this part as needed
	logic 		 [4:0]	  letter0, letter1, letter2, letter3, letter4, letter5;
	
	// Lab logic
	// U, P, C inputs will be SW 9, 8, 7, respectively
	// SW 0 is used for the secret Mark
	// Use LEDR 1 and 0 for Discounted and Stolen, respectively
	seg7_new display0 (.letter(letter0), .leds(HEX5[6:0]));
	seg7_new display1 (.letter(letter1), .leds(HEX4[6:0]));
	seg7_new display2 (.letter(letter2), .leds(HEX3[6:0]));
	seg7_new display3 (.letter(letter3), .leds(HEX2[6:0]));
	seg7_new display4 (.letter(letter4), .leds(HEX1[6:0]));
	seg7_new display5 (.letter(letter5), .leds(HEX0[6:0]));
	
	// This should only have six outputs corresponding to the six possible UPC codes
	// Alphabet is... 26 possible values, so 5 bits to accomodate (32 possible)
	// ABCDEFGHIJKLMNOPQRSTUVWXY Z
	// 0123456789ABCDEF          25
	always_comb begin
		case(SW[9:7])
//			1:		  begin // test if this corresponds to 001... it works! But, use this idea for letter translation
			3'b000: begin		// DRUGS
				letter0 = 3;
				letter1 = 17;
				letter2 = 20;
				letter3 = 6;
				letter4 = 18;
				letter5 = 26;
			end
			3'b001: begin		// MOLLY 
				letter0 = 13;
				letter1 = 13;
				letter2 = 14;
				letter3 = 11;
				letter4 = 11;
				letter5 = 24;
			end
			3'b011: begin		// SOAP
				letter0 = 18;
				letter1 = 14;
				letter2 = 0;
				letter3 = 15;
				letter4 = 26;
				letter5 = 26;
			end
			3'b100: begin		// LEDS
				letter0 = 11;
				letter1 = 4;
				letter2 = 3;
				letter3 = 18;
				letter4 = 26;
				letter5 = 26;
			end
			3'b101: begin		// YARN
				letter0 = 24;
				letter1 = 0;
				letter2 = 17;
				letter3 = 13;
				letter4 = 26;
				letter5 = 26;
			end
			3'b110: begin		// IPHONE
				letter0 = 8;
				letter1 = 15;
				letter2 = 7;
				letter3 = 14;
				letter4 = 13;
				letter5 = 4;
			end
			default: begin 
				letter0 = 26;
				letter1 = 26;
				letter2 = 26;
				letter3 = 26;
				letter4 = 26;
				letter5 = 26;
			end
		endcase
	end
	
	
//	seg7 Hex0 (.bcd(SW[3:0]), .leds(HEX0[6:0]));
//	seg7 Hex1 (.bcd(SW[7:4]), .leds(HEX1[6:0]));
	
	// Use SW 9, 8, and 7 for U, P, and C, respectively
	// Use SW 0 for the secret Mark
	// Use LEDR 1 and 0 for Discounted and Stolen, respectively
	// ??? Can you assign more convenient names?
//	assign LEDR[1] = SW[8] | (SW[9] & SW[7]); // Discounted
//
//	assign A = (~SW[8] & ~SW[7] & ~SW[0]);
//	assign B = (SW[9] & ~SW[8] & ~SW[0]);
//	assign LEDR[0] = A | B; // Stolen
	
endmodule 

//module DE1_SoC_testbench();
//	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Take out input/output "tags"
//	logic [9:0] LEDR;
//	logic [3:0] KEY;
//	logic [9:0] SW;
//	
//	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
//	
//	// Try all combinations of inputs. 
//	integer i;
//	initial begin
//		SW[6] = 1'b0;
//		SW[5] = 1'b0;
//		SW[4] = 1'b0;
//		SW[3] = 1'b0;
//		SW[2] = 1'b0;
//		SW[1] = 1'b0;
//		for (i = 0; i < 16; i++) begin
//			{SW[9], SW[8], SW[7], SW[0]} = i; #10;
//		end
//	end
//endmodule 