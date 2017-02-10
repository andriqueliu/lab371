// Display module for scanner

module display (HEX, status);
	output reg [6:0] HEX;
	input [4:0] status;
	reg [6:0] nil, A, d, E, h, I, L, o, n, P,  S, t, U, r, c, F;

	assign nil = 7'b1111111;
	assign I = 7'b1111001;
	assign S = 7'b0010010;
	assign t = 7'b0000111;
	assign F = 7'b0111000;

	always@(*)
		case(status)
			5'b10000 : begin
							//IDLE state
							HEX = I;
						end
			5'b01000 : begin
							//SCAN
							HEX = S;
						end
			5'b00100 : begin
							//Transfer
							HEX = t;
						end
			5'b00001 : begin
							//FLUSH
							HEX = F;
						end
			default : begin
							HEX = nil;
						end
		endcase
endmodule
