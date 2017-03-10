/*
EE 371 Final Project
2-Player Connect Four

Authors: Andrique Liu, Emraj Sidhu, Nikhil Grover

column_manager instantiates and operates six nodes. This module manages
the stacking of discs on top of each other in a single column. Also, this module
indicates whether a particular node is active, and if it is, what color it is.
*/
module column_manager (clk, reset, drop_red, drop_green, red_on, green_on);
	input  logic clk, reset; // Clock, Reset signals
	input  logic drop_red, drop_green; // Player input: drop red or green discs
	
	// These registers determine whether a node is active, and if it is, what
	// color it is active with.
	output logic [5:0] red_on, green_on;
	
	// available_nodes indicates which node is next to be filled
	// node_on is used for debugging: is the node on at all?
	logic [5:0] available_nodes, node_on;
	
	integer count; // How many discs are currently in the column?
	
	// -------------------------------------------------------- //
	// Generate the nodes
	
	genvar node_i;
	
	generate
		for (node_i = 0; node_i < 6; node_i++) begin : each_node
			node one_node (.clk, .reset, .node_available(available_nodes[node_i]),
			               .drop_red, .drop_green,
                        .red_on(red_on[node_i]), .green_on(green_on[node_i]));
		end
	endgenerate
	
	// End generation block
	// -------------------------------------------------------- //
	
	// Initial Logic
	initial begin
		count = 0;
	end
	
	// This shift operation determines the next node that can be occupied.
	// Example:
	// If count is 0, then the lowest node (...001) is the next to be occupied.
	// If count is 1, then the next higher node (...010) is next, etc.
	assign available_nodes = 6'b01 << count;
	
	// Integer used to iterate through nodes; used for node_on.
	integer node_on_i;
	
	// Combinational Logic
	// Node_on: is the node on at all? (Red or green)
	always_comb begin
		for (node_on_i = 0; node_on_i < 6; node_on_i++) begin
			node_on[node_on_i] = red_on[node_on_i] || green_on[node_on_i];
		end
	end
	
	// Sequential Logic
	// At reset, the count goes back to 0.
	// Else if either player drops a red or a green, the count increments.
	always_ff @(posedge clk) begin
		if (reset) begin
			count <= 0;
		end else if (drop_red || drop_green) begin
			count <= count + 1;
		end
	end
	
endmodule

// Tester Module
module column_manager_testbench();
	logic clk, reset;
	logic drop_red, drop_green;
	
	logic [5:0] red_on, green_on;
	
	column_manager dut (clk, reset, drop_red, drop_green, red_on, green_on);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	reset <= 1; 			  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_red <= 1;         @(posedge clk);
	drop_red <= 0;         @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_green <= 1;       @(posedge clk);
	drop_green <= 0;       @(posedge clk);
	drop_red <= 1;         @(posedge clk);
	drop_red <= 0;         @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_green <= 1;       @(posedge clk);
	drop_green <= 0;       @(posedge clk);
	drop_red <= 1;         @(posedge clk);
	drop_red <= 0;         @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_green <= 1;       @(posedge clk);
	drop_green <= 0;       @(posedge clk);
	drop_red <= 1;         @(posedge clk);
	drop_red <= 0;         @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_green <= 1;       @(posedge clk);
	drop_green <= 0;       @(posedge clk); // Eight
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	drop_red <= 1;         @(posedge clk);
	drop_red <= 0;         @(posedge clk);
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
