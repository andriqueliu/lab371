// Authors: Andrique Liu, Emraj Sidhu, Nikhil Grover
// This modules alternates between player 1 (us) and player 2 (the other group) 
// for our connect four game
module change_Player(clk, reset, player_input, leds);
	input  logic clk, reset;
	// Enter makes a move; each player gets to make one move during their turn.
	input  logic enter;
	
	output logic leds[1:0];
	
	// State Variables
	enum { PLAYER_1, PLAYER_2 } ps, ns;
	
	always_comb begin
		case (ps)
			PLAYER_1: begin
				
			end
			
			PLAYER_2: begin
				
			end
		endcase
	end
	
	// 
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= PLAYER_1;
		end else if () begin
			ps <= ns;
		end
	end
	
	// Assigns leds to let us know when player 1 has taken his turn and when player 2 has
	assign leds = ps;
	
endmodule 

// Tester Module
module change_Player_testbench();
	logic clk, reset;
	logic player_input;
	logic [1:0] leds;
	
	change_Player dut (clk, reset, player_input, leds);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
// Set up the inputs to the design. Each line is a clock cycle.
 initial begin
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		                           @(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);									
											@(posedge clk);
		                           @(posedge clk);
											@(posedge clk);
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
	