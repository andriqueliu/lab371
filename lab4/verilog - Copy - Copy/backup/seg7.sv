module seg7 (bcd, leds);
	input logic [3:0] bcd;
	output logic [6:0] leds;
	
	always_comb
		case (bcd)
			// !!! the DE1's 7seg display is ACTIVE LOW, so flip everything around
			//          Light: 6543210
			4'b0000: leds = 7'b0111111; // 0
			4'b0001: leds = 7'b0000110; // 1
			4'b0010: leds = 7'b1011011; // 2
			4'b0011: leds = 7'b1001111; // 3
			4'b0100: leds = 7'b1100110; // 4
			4'b0101: leds = 7'b1101101; // 5
			4'b0110: leds = 7'b1111101; // 6
			4'b0111: leds = 7'b0000111; // 7
			4'b1000: leds = 7'b1111111; // 8
			4'b1001: leds = 7'b1101111; // 9
			default: leds = 7'bX;
			
//			4'b0000: leds = 7'b1000000; // 0 
//			4'b0001: leds = 7'b1111001; // 1 done through here
//			4'b0010: leds = 7'b0100100; // 2
//			4'b0011: leds = 7'b0110000; // 3
//			4'b0100: leds = 7'b0011001; // 4
//			4'b0101: leds = 7'b0010010; // 5
//			4'b0110: leds = 7'b0000010; // 6
//			4'b0111: leds = 7'b1111000; // 7
//			4'b1000: leds = 7'b0000000; // 8
//			4'b1001: leds = 7'b0010000; // 9
//			default: leds = 7'bX;
		endcase
endmodule