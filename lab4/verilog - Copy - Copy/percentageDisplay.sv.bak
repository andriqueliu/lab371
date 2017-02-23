//Percentage LED display

module percentageDisplay(HEX5, percent);
	ouput [6:0] HEX5
	input [9:0] percent;

	always@(*)
		case(percent)
			10'b1000000000 : begin
									//ten percent
									assign HEX5 = 7'b1001111;
							end
			10'b0100000000 : begin
									//twenty percent
									assign HEX5 = 7'b0010010;
							end
			10'b0010000000 : begin
									//thirty percent
									assign HEX5 = 7'b0000110;
							end
			10'b0001000000 : begin
									//forty percent
									assign HEX5 = 7'b1001100;
							end
			10'b0000100000 : begin
									//fifty percent
									assign HEX5 = 7'b0100101;
							end
			10'b0000010000 : begin
									//sixty percent
									assign HEX5 = 7'b0100000;
							end
			10'b0000001000 : begin
									//seventy percent
									assign HEX5 = 7'b0001111;
							end
			10'b0000000100 : begin
									//eighty percent
									assign HEX5 = 7'b0000000;
							end
			10'b0000000010 : begin
									//ninety percent
									assign HEX5 = 7'b0000100;
							end
			10'b0000000001 : begin
									//one-hundred percent, represented by F
									assign HEX5 = 7'b0111000;
							end
					default : begin
									assign HEX5 = 7'b1111111;
							end
		endcase					