/*




*/
module local_col_FSM (clk, reset, i, column_in, column_out);
	input  logic clk, reset;
	input  integer i;
	input  logic column_in;
	output logic column_out;
	
	enum { DEFAULT, MATCH } ps, ns;
	
	always_comb begin
		case (ps)
			DEFAULT: begin
				if ((i % 3) == 0) begin
					ns = MATCH;
					column_out = column_in;
				end else begin
					ns = DEFAULT;
					column_out = {7{1'b0}};
				end
			end
			
			MATCH: begin
				if ((i % 3) != 0) begin
					ns = DEFAULT;
				end else begin
					ns = MATCH;
				end
				column_out = {7{1'b0}};
			end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= DEFAULT;
		end else begin
			ps <= ns;
		end
	end
	
endmodule
