/*




*/
module node (clk, reset, node_available, drop_red, drop_green,
             red_on, green_on);
	input  logic clk, reset;
	input  logic node_available;
	input  logic drop_red, drop_green;
	
	output logic red_on, green_on;
	
	// State Variables
	enum { OFF, RED, GREEN } ps, ns;
	
	// 
	// 
	always_comb begin
		case (ps)
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
			
			RED: begin
				ns = RED;
				red_on = 1;
				green_on = 0;
			end
			
			GREEN: begin
				ns = GREEN;
				red_on = 0;
				green_on = 1;
			end
		endcase
	end
	
	// Sequential Logic
	// 
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
