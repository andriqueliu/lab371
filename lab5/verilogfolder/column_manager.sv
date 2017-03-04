/*




*/
module column_manager (clk, reset, drop_red, drop_green, available_nodes);
	input  logic clk, reset;
	input  logic drop_red, drop_green;
	
	// Communicate with each node; tell node whether it is able to be filled.
	// Haven't decided... inst. node inside here? Or alongside?
	output logic [7:0] available_nodes;
	
	integer count;
	
	// 
	initial begin
		count = 0;
	end
	
	// 
	assign available_nodes = 8'b01 << count;
	
	// 
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
	
	logic [7:0] available_nodes;
	
	column_manager dut (clk, reset, drop_red, drop_green, available_nodes);
	
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
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
