/*
EE 371 Final Project
2-Player Connect Four

Authors: Emraj Sidhu, Nikhil Grover, Andrique Liu

This modules alternates between Player 1 (us) and Player 2 (the other group).
Transitions between states occur in response to the 3-bit serial IO sequences.

For instance, our turn goes to their turn when we have sent 3 bits.
Conversely, their turn goes to our turn when we have received 3 bits.
*/
module change_Player (clk, reset, enter, ready_in, three_in, three_out, P1, P2, ready_out);
	input  logic clk, reset; // Clock, Reset signals
	// enter makes a move; each player gets to make one move during their turn.
	// ready_in is OBSOLETE in this module
	input  logic enter, ready_in;
	
	// Three_in indicates that the serial input module has received a full 3-bit sequence
	// Three_out indicates that the serial output module has sent a full 3-bit sequence
	input  logic three_in, three_out;
	
	// 
	output logic P1, P2;
	output logic ready_out;
	
	// State Variables
	enum { PLAYER_1, PLAYER_2 } ps, ns;
	
	// 
	always_comb begin
		case (ps)
			PLAYER_1: begin
				if (three_out) begin
					ns = PLAYER_2;
					ready_out = 1;
				end else begin
					ns = PLAYER_1;
					ready_out = 0;
				end
				P1 = 1;
				P2 = 0;
			end
			
			PLAYER_2: begin
//				if (ready_in) begin
				if (three_in) begin
					ns = PLAYER_1;
					ready_out = 0;
				end else begin
					ns = PLAYER_2;
					ready_out = 1;
				end
				P1 = 0;
				P2 = 1;
			end
		endcase
	end
	
	// 
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= PLAYER_1;
		end else begin
			ps <= ns;
		end
	end
	
endmodule 

//// Tester Module
//module change_Player_testbench();
//	logic clk, reset; 
//	logic enter, ready_in;
//	
//	logic P1, P2;
//	logic ready_out;
//	
//	change_Player dut (clk, reset, enter, ready_in, P1, P2, ready_out);
//	
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	initial begin
//	enter <= 0;	ready_in <= 1;    @(posedge clk);
//											@(posedge clk);
//	reset <= 1;                   @(posedge clk);
//	reset <= 0;                   @(posedge clk);
//		                           @(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//	enter <= 1;                   @(posedge clk);
//	enter <= 0; ready_in <= 0;                  @(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);									
//											@(posedge clk);
//	ready_in <= 1;	                           @(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//											@(posedge clk);
//		                           @(posedge clk);
//							
//
//	$stop; // End the simulation.
//	end
//endmodule 
	