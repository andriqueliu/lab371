/*
EE 469 Lab 3 Project
Designing an ALU
Authors: Andrique Liu, Grant Maiden, Zhengjie Zhu

hexDriver functions as the driver for the hex displays.
Each hexDriver module controls a single hex display digit, and represents
a 4-bit binary value/1-bit hex value.

This module takes a 4-bit binary input, and outputs to a single hex display.

Note: hexDriver's input values range from 0 through 15 (F)
*/
module hexDriver (value, leds);
	input  logic [3:0] value; // Input bits
	
	output logic [6:0] leds;  // Hex display output
	
	// Combinational Logic
	// Input value selects which pattern to display on LEDs
	always_comb begin
		case (value) 
			//            Light: 6543210
			4'b0000: leds = ~(7'b0111111); // 0
			4'b0001: leds = ~(7'b0000110); // 1
			4'b0010: leds = ~(7'b1011011); // 2
			4'b0011: leds = ~(7'b1001111); // 3
			4'b0100: leds = ~(7'b1100110); // 4
			4'b0101: leds = ~(7'b1101101); // 5
			4'b0110: leds = ~(7'b1111101); // 6
			4'b0111: leds = ~(7'b0000111); // 7
			4'b1000: leds = ~(7'b1111111); // 8
			4'b1001: leds = ~(7'b1101111); // 9
			4'b1010: leds = ~(7'b1110111); // 10/A
			4'b1011: leds = ~(7'b1111100); // 11/B
			4'b1100: leds = ~(7'b0111001); // 12/C
			4'b1101: leds = ~(7'b1011110); // 13/D
			4'b1110: leds = ~(7'b1111001); // 14/E
			4'b1111: leds = ~(7'b1110001); // 15/F
			
			default: leds = ~(7'b0000000); // Default case: display nothing
		endcase
	end
	
endmodule
