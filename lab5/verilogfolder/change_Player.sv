// Authors: Andrique Liu, Emraj Sidhu, Nikhil Grover
// This modules alternates between player 1 (us) and player 2 (the other group) 
// for our connect four game

module change_Player(clk, reset, player_input, leds);
	input logic clk, reset;
	input logic player_input;
	output logic leds[1:0];
	
	reg ps, ns;
	
	parameter [1:0] p1 = 2'b01, p2 = 2'b00;
	
	always @(*) 
		case(ps)
			p1:            if (player_input == 1)             ns = p2;        
								else                     			  ns = p1;
			p2:            if (player_input == 0)             ns = p1;
							   else 							           ns = p2;
			default:                                          ns = p1;
		endcase 
	
	// Assigns leds to let us know when player 1 has taken his turn and when player 2 has
	assign leds = ps;
	
	// DFFs
	always_ff @(posedge clk)
		ps <= ns;
endmodule 

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
	