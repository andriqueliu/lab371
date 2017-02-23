module items (upc, hex); // note: this module's outputs are only hooked up to the outputs of a SINGLE hex display
	input logic [2:0] upc;
	output logic [5:0] hex;
	
	always_comb
		case (bcd)
			// !!! the DE1's 7seg display is ACTIVE LOW, so flip everything around
			//          Light: 6543210
			// this is pretty much 
			4'b0000: leds = ~(7'b0111111); // 0... note: later, letters will take the place of these "numbers"
			4'b0001: leds = ~(7'b0000110); // 1
			4'b0010: leds = ~(7'b1011011); // 2
			4'b0011: leds = ~(7'b1001111); // 3
			4'b0100: leds = ~(7'b1100110); // 4
			4'b0101: leds = ~(7'b1101101); // 5
			4'b0110: leds = ~(7'b1111101); // 6
			4'b0111: leds = ~(7'b0000111); // 7
			4'b1000: leds = ~(7'b1111111); // 8
			4'b1001: leds = ~(7'b1101111); // 9
			default: leds = 7'bX;
		endcase
endmodule