//Display module for scanner

module display(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW)
	output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input [4:0] status;
	reg [6:0] nil, A, d, E, h, I, L, o, n, P,  S, t, U, r, c, F;

	assign nil = 7'b1111111;
	assign A = 7'b0001000;
	assign d = 7'b0100001;
	assign E = 7'b0000110;
	assign h = 7'b0001011;
	assign I = 7'b1111001;
	assign L = 7'b1000111;
	assign o = 7'b0100011;
	assign n = 7'b0101011;
	assign P = 7'b0001100;
	assign S = 7'b0010010;
	assign t = 7'b0000111;
	assign U = 7'b1000001;
	assign r = 7'b1111010;
	assign c = 7'b1110010;
	assign F = 7'b0111000;

	always@(*)
		case(status)
			5'b01000 : begin
							//IDLE state
							HEX5 = nil;
							HEX4 = nil;
							HEX3 = I;
							HEX2 = d;
							HEX1 = L;
							HEX0 = E;
						end
			5'b10000 : begin
							//SCAN
							HEX5 = nil;
							HEX4 = nil;
							HEX3 = S;
							HEX2 = c;
							HEX1 = A;
							HEX0 = n;
						end
			5'b00100 : begin
							//Transfer
							HEX5 = nil;
							HEX4 = t;
							HEX3 = r;
							HEX2 = A;
							HEX1 = n;
							HEX0 = S;
						end
			5'b00001 : begin
							//FLUSH
							HEX5 = nil;
							HEX4 = F;
							HEX3 = L;
							HEX2 = U;
							HEX1 = S;
							HEX0 = h;
						end
			default : begin
							HEX5 = nil;
							HEX4 = nil;
							HEX3 = nil;
							HEX2 = nil;
							HEX1 = nil;
							HEX0 = nil;
						end
		endcase
endmodule