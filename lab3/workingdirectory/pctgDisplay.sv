// Percentage LED display

module pctgDisplay(HEX5, address);
	output [6:0] HEX5;
	input  integer address;
	
	// 
	// 
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
	
//	always@(*) begin
//		case(percent)
//			10'b0000000000 : begin
//									//zero percent
//									HEX5 = 7'b1111111;
//							end
//			10'b1000000000 : begin
//									//ten percent
//									HEX5 = 7'b1001111;
//							end
//			10'b0100000000 : begin
//									//twenty percent
//									HEX5 = 7'b0010010;
//							end
//			10'b0010000000 : begin
//									//thirty percent
//									HEX5 = 7'b0000110;
//							end
//			10'b0001000000 : begin
//									//forty percent
//									HEX5 = 7'b1001100;
//							end
//			10'b0000100000 : begin
//									//fifty percent
//									HEX5 = 7'b0100101;
//							end
//			10'b0000010000 : begin
//									//sixty percent
//									HEX5 = 7'b0100000;
//							end
//			10'b0000001000 : begin
//									//seventy percent
//									HEX5 = 7'b0001111;
//							end
//			10'b0000000100 : begin
//									//eighty percent
//									HEX5 = 7'b0000000;
//							end
//			10'b0000000010 : begin
//									//ninety percent
//									HEX5 = 7'b0000100;
//							end
//			10'b0000000001 : begin
//									//one-hundred percent, represented by F
//									HEX5 = 7'b0111000;
//							end
//					default : begin
//									HEX5 = 7'b1111111;
//							end
//		endcase
//	end
	
endmodule
