/*
EE 371 Final Project
2-Player Connect Four

Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

node functions as a single node in the Connect Four playing field.
In the final game, node is instantiated 42 times (6 rows by 7 columns).
A node indicates whether it is active, and if it is, whether it is red or green.
Player input allows discs to be dropped, which eventually occupy empty nodes.
*/
module node (clk, reset, node_available, drop_red, drop_green,
             red_on, green_on);
	input  logic clk, reset; // Clock, Reset Signals
	input  logic node_available; // Is the node available?
	// Drop a red or green disc into this node
	input  logic drop_red, drop_green;
	
	// On: red or green
	output logic red_on, green_on;
	
	// State Variables
	enum { OFF, RED, GREEN } ps, ns;
	
	// Combinational/Next State Logic
	always_comb begin
		case (ps)
			// If the node is available and it sees a drop red or drop green
			// signal, it will turn active and become that respective color.
			OFF: begin
				if (node_available && drop_red) begin
					ns = RED;
				end else if (node_available && drop_green) begin
					ns = GREEN;
				end else begin
					ns = OFF;
				end
				red_on = 0;
				green_on = 0;
			end
			
			// Remain red
			RED: begin
				ns = RED;
				red_on = 1;
				green_on = 0;
			end
			
			// Remain green
			GREEN: begin
				ns = GREEN;
				red_on = 0;
				green_on = 1;
			end
		endcase
	end
	
	// Sequential Logic
	// If reset, go OFF. Else, go to the next state.
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= OFF;
		end else begin
			ps <= ns;
		end
	end
	
endmodule

// Tester Module
module node_testbench();
	logic clk, reset;
	logic node_available;
	logic drop_red, drop_green;
	
	logic red_on, green_on;
	
	node dut (clk, reset, node_available, drop_red, drop_green,
             red_on, green_on);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	drop_red <= 0; drop_green <= 0; node_available <= 0; @(posedge clk);
	reset <= 1; 			  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_red <= 1;         @(posedge clk);
	drop_red <= 0;         @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	node_available <= 1;        @(posedge clk);
	drop_red <= 1;         @(posedge clk);
	drop_red <= 0;         @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_green <= 1;       @(posedge clk);
	drop_green <= 0;       @(posedge clk);
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
