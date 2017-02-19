// Andrique Liu

// Controls behavior of hex display
module seg7 (bcd, leds); // note: this module's outputs are only hooked up to the outputs of a SINGLE hex display
	input logic [2:0] bcd;
	output logic [6:0] leds;
	
	always_comb
		case (bcd)
			//            Light: 6543210
			4'b0000: leds = ~(7'b0111111); // 0... note: later, letters will take the place of these "numbers"
			4'b0001: leds = ~(7'b0000110); // 1
			4'b0010: leds = ~(7'b1011011); // 2
			4'b0011: leds = ~(7'b1001111); // 3
			4'b0100: leds = ~(7'b1100110); // 4
			4'b0101: leds = ~(7'b1101101); // 5
			4'b0110: leds = ~(7'b1111101); // 6
			4'b0111: leds = ~(7'b0000111); // 7
			default: leds = 7'bX;
		endcase
		
endmodule

module seg7_testbench();
	logic [2:0] bcd;
	logic [6:0] leds;
	
	seg7 dut (bcd, leds);
	
	// Try all combinations of inputs. 
	integer i;
	initial begin
		bcd[2:0] = 3'b000;
		
		for (i = 0; i < 8; i++) begin
			{bcd[2], bcd[1], bcd[0]} = i; #10;
		end
	end
endmodule 