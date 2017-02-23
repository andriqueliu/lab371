// Andrique Liu

// Manage SIX hex displays and two LEDRS using 4 switch inputs
// This will be isntantiated by a higher-level top module
module UPC_Manager (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW);
   output logic [6:0]     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // this means that EACH HEX_ has 7 bits attached to it
	input  logic [9:0]     SW;
	logic 		 [4:0]	  letter0, letter1, letter2, letter3, letter4, letter5;
	
	// Lab logic
	// U, P, C inputs will be SW 9, 8, 7, respectively
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
		case(SW[9:7]) // looks at switches 9 through 7
//			1:		  begin // test if this corresponds to 001... it works! But, use this idea for letter translation
			3'b000: begin		// DRUGS
				letter0 = 3;
				letter1 = 17;
				letter2 = 20;
				letter3 = 6;
				letter4 = 18;
				letter5 = 26;
			end
			3'b001: begin		// CANDY
				letter0 = 2;
				letter1 = 0;
				letter2 = 13;
				letter3 = 3;
				letter4 = 24;
				letter5 = 26;
			end
			3'b011: begin		// SOAP
				letter0 = 18;
				letter1 = 14;
				letter2 = 0;
				letter3 = 15;
				letter4 = 26;
				letter5 = 26;
			end
			3'b100: begin
				letter0 = 8;   // IPHONE
				letter1 = 15;
				letter2 = 7;
				letter3 = 14;
				letter4 = 13;
				letter5 = 4;
			end
			3'b101: begin		// DROID
				letter0 = 3;
				letter1 = 17;
				letter2 = 14;
				letter3 = 8;
				letter4 = 3;
				letter5 = 26;
			end
			3'b110: begin		// LEDS
				letter0 = 11;
				letter1 = 4;
				letter2 = 3;
				letter3 = 18;
				letter4 = 26;
				letter5 = 26;
				
			end
			default: begin // if inputs do not match known UPC codes, assigned Don't Cares
				letter0 = 5'bX;
				letter1 = 5'bX;
				letter2 = 5'bX;
				letter3 = 5'bX;
				letter4 = 5'bX;
				letter5 = 5'bX;
			end
		endcase
	end
	
endmodule 

module UPC_Manager_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] SW;
	
	UPC_Manager dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .SW);
	
	// Try all combinations of inputs. 
	integer i;
	initial begin
		SW[6] = 1'b0;
		SW[5] = 1'b0;
		SW[4] = 1'b0;
		SW[3] = 1'b0;
		SW[2] = 1'b0;
		SW[1] = 1'b0;
		for (i = 0; i < 8; i++) begin
			{SW[9], SW[8], SW[7]} = i; #10;
		end
//		for (i = 0; i < 16; i++) begin
//			{SW[9], SW[8], SW[7], SW[0]} = i; #10;
//		end
	end
endmodule 