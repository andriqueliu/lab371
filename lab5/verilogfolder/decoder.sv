/*
EE 371 Final Project
2-Player Connect Four

Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

decoder is used to decode from binary data to decode data.

The pattern is as follows:
	001: 0000001
	010: 0000010
	etc.
*/
module decoder (clk, reset, binary_data, decoded_data);
	input  logic clk, reset;
	input  logic [2:0] binary_data;
	
	output logic [6:0] decoded_data;
	
	always_comb begin
		case (binary_data)
			3'b001: begin
				decoded_data = 7'b0000001;
			end
			3'b010: begin
				decoded_data = 7'b0000010;
			end
			3'b011: begin
				decoded_data = 7'b0000100;
			end
			3'b100: begin
				decoded_data = 7'b0001000;
			end
			3'b101: begin
				decoded_data = 7'b0010000;
			end
			3'b110: begin
				decoded_data = 7'b0100000;
			end
			3'b111: begin
				decoded_data = 7'b1000000;
			end
			default: begin
//				decoded_data = {7{1'b0}};
				decoded_data = 7'b1111111;
			end
		endcase
	end
	
endmodule
