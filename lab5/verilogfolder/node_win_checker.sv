// Authors: Andrique Liu, Emraj Sidhu, Nikhil Grover
// Connect four
// This module contains logic for when the game is won.

module node_win_checker (clk, reset, node_on, right_1, right_2, right_3, up_1, up_2, up_3,
left_1, left_2, left_3, down_1, down_2, down_3, ur_1, ur_2, ur_3, dr_1, dr_2, dr_3, d1_1, d1_2,
d1_3, u1_1, u1_2, u1_3, game_won);
	input  logic clk, reset;
	input  logic node_on;
	input  logic right_1, right_2, right_3, up_1, up_2, up_3;
	input  logic left_1, left_2, left_3, down_1, down_2, down_3;
	input  logic ur_1, ur_2, ur_3, dr_1, dr_2, dr_3;
	input  logic d1_1, d1_2, d1_3, u1_1, u1_2, u1_3;
	output logic game_won;
	
	// Combinational Logic
	// 
	always_comb begin
		if ((~reset) && ((node_on && right_1 && right_2 && right_3) ||
			 (left_1 && node_on && right_1 && right_2) ||
			 (left_2 && left_1 && node_on && right_1) ||
			 (left_1 && left_2 && left_3 && node_on) || (up_1 && up_2 &&
			  up_3 && node_on) || (up_1 && up_2 && node_on && down_1) || 
			  (node_on && dr_1 && dr_2 && dr_3) || (u1_1 && node_on && dr_1
			  && dr_2) || (u1_1 && u1_2 && node_on && dr_1) || (u1_1 && u1_2
			  && u1_3 && node_on) || (node_on && d1_1 && d1_2 && d1_3)||
			  (ur_1 && node_on && d1_1 && d1_2) || (ur_1 && ur_2 && node_on
			  && d1_1) || (ur_1 && ur_2 && ur_3 && node_on))) begin
			game_won = 1;
		end else begin
			game_won = 0;
		end
	end
	
endmodule

module node_win_checker_testbench();
	logic clk, reset;
	logic node_on, right_1, right_2, right_3, up_1, up_2, up_3;
	logic left_1, left_2, left_3, down_1, down_2, down_3;
	logic ur_1, ur_2, ur_3, dr_1, dr_2, dr_3;
	logic d1_1, d1_2, d1_3, u1_1, u1_2, u1_3;
	logic game_won;
	
	node_win_checker dut(clk, reset, node_on, right_1, right_2, right_3, up_1, up_2, up_3,
	left_1, left_2, left_3, down_1, down_2, down_3, ur_1, ur_2, ur_3, dr_1, dr_2, dr_3,
	d1_1, d1_2, d1_3, u1_1, u1_2, u1_3, game_won);
	
	 // Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end
 
 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
reset <= 0;				@(posedge clk);
node_on <= 1;			@(posedge clk);
right_1 <= 1;			@(posedge clk);
right_2 <= 1;			@(posedge clk);
right_3 <= 1;			@(posedge clk);
							@(posedge clk);
reset <= 1;				@(posedge clk);
reset <= 0;				@(posedge clk);
node_on <= 0; right_1 <= 0; right_2 <= 0; right_3 <=0;							@(posedge clk);
ur_1 <= 1;				@(posedge clk);
ur_2 <= 1;				@(posedge clk);
node_on <= 1;			@(posedge clk);
d1_1 <= 1;				@(posedge clk);
							@(posedge clk);
reset <= 1;				@(posedge clk);
reset <= 0;				@(posedge clk);
							@(posedge clk);
u1_1 <= 1;				@(posedge clk);
u1_2 <= 1;				@(posedge clk);
d1_2 <= 1;				@(posedge clk);
node_on <= 1;			@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
 $stop; // End the simulation.
 end
endmodule 
