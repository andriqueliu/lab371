/*

*/
module pctgDisplay(HEX5, address);
	output logic [6:0] HEX5;
	input  integer address;
	
	// Determines the proper percentage to display on a hex display
	always_comb begin
		if (address < 75) begin // Zero percent
			HEX5 = ~(7'b0111111);
		end else if (address < 75 * 2) begin
			HEX5 = ~(7'b0000110);
		end else if (address < 75 * 3) begin
			HEX5 = ~(7'b1011011);
		end else if (address < 75 * 4) begin
			HEX5 = ~(7'b1001111);
		end else if (address < 75 * 5) begin
			HEX5 = ~(7'b1100110);
		end else if (address < 75 * 6) begin
			HEX5 = ~(7'b1101101);
		end else if (address < 75 * 7) begin
			HEX5 = ~(7'b1111101);
		end else if (address < 75 * 8) begin
			HEX5 = ~(7'b0000111);
		end else if (address < 75 * 9) begin
			HEX5 = 7'b0000000;
		end else if (address < 749) begin
			HEX5 = ~(7'b1101111);
		end else if (address == 749) begin
			HEX5 = ~(7'b1110001);
		end else begin
			HEX5 = 7'b1111111;
		end
	end
	
endmodule
