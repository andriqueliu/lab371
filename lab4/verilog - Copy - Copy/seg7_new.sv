// Andrique Liu

// seg7_new manages a single hex display
module seg7_new (letter, leds); // note: this module's outputs are only hooked up to the outputs of a SINGLE hex display
	input logic  [4:0] letter;
	output logic [6:0] leds;
	
	always_comb begin
		case (letter)
			// !!! the DE1's 7seg display is ACTIVE LOW, so flip everything around using ~()
			//      Light: 6543210
			0: leds = ~(7'b1110111); // 0... note: later, letters will take the place of these "numbers"... ??? possible?
			1: leds = ~(7'b1111100); // B
			2: leds = ~(7'b0111001); // C
			3: leds = ~(7'b1011110); // D
			4: leds = ~(7'b1111001); // E
			5: leds = ~(7'b1110001); // F
			6: leds = ~(7'b1111101); // G
			7: leds = ~(7'b1110100); // H
			8: leds = ~(7'b0000110); // I
			9: leds = ~(7'b0001110); // J
			10: leds = ~(7'b1110110); // K
			11: leds = ~(7'b0111000); // L
			12: leds = ~(7'bX); // M?
			13: leds = ~(7'b0110111); // N
			14: leds = ~(7'b0111111); // O
			15: leds = ~(7'b1110011); // P
			16: leds = ~(7'b1100111); // Q
			17: leds = ~(7'b1010000); // R
			18: leds = ~(7'b1101101); // S
			19: leds = ~(7'b0000111); // T
			20: leds = ~(7'b0111110); // U
			21: leds = ~(7'bX); // V?
			22: leds = ~(7'bX); // W?
			23: leds = ~(7'bX); // X?
			24: leds = ~(7'b1100110); // Y
			25: leds = ~(7'b1011011); // Z
			26: leds = ~(7'b0000000); // OFF
			default: leds = 7'bX;
		endcase
	end
endmodule

module seg7_new_testbench();
	logic [4:0] letter;
	logic [6:0] leds;
	
	seg7_new dut (.letter, .leds);
	
	// Try all combinations of inputs. 
	integer i;
	initial begin
		for (i = 0; i < 32; i++) begin
			{letter[4], letter[3], letter[2], letter[1], letter[0]} = i; #10;
		end
//		for (i = 0; i < 16; i++) begin
//			{SW[9], SW[8], SW[7], SW[0]} = i; #10;
//		end
	end
endmodule 