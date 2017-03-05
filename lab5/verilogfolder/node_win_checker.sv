/*



Note: We'll actually have TWO win checker nodes assigned to each real
node. One win checker monitors reds, one win checker monitors greens
*/
module node_win_checker (clk, reset, );
	input  logic clk, reset;
	input  logic node_on;
	input  logic right_1, right_2, right_3, up_1, up_2, up_3;
	input  logic left_1, left_2, left_3, down_1, down_2, down_3;
	input  logic ur_1, ur_2, ur_3, dr_1, dr_2, dr_3;
	input  logic dl_1, dl_2, dl_3, ul_1, ul_2, ul_3;
	
	output logic game_won;
	
	// Combinational Logic
	// 
	always_comb begin
		if ((node_on && right_1 && right_2 && right_3) ||
			 (left_1 && node_on && right_1 && right_2) ||
			 (left_2 && left_1 && node_on && right_1) ||
			 ()) begin
			game_won = 1;
		end else begin
			game_won = 0;
		end
	end
	
endmodule
