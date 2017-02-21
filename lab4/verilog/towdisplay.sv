module towdisplay (clk, reset, win2, win1, leds);
	input  logic 		 clk, reset;
	input  logic       win2, win1;
	output logic [6:0] leds;
	
	enum { NONE, P1, P2 } ps, ns;
	
	always_comb begin
		case (ps)
			NONE: begin
				if (win2) begin
					ns = P2;
//					leds = ~(7'b1011011); // 2
					leds = ~(7'b0000000); // all OFF
				end else if (win1) begin
					ns = P1;
//					leds = ~(7'b0000110); // 1
					leds = ~(7'b0000000); // all OFF
				end else begin
					ns = NONE;
					leds = ~(7'b0000000); // all OFF
				end
			end
			P1: begin
				ns = P1;
				leds = ~(7'b0000110); // 1
			end
			P2: begin
				ns = P2;
				leds = ~(7'b1011011); // 2
			end
			default: leds = ~(7'bX); // Don't Cares
		endcase
	end
		
	// DFFs
	// !!! This means: only execute when you see a posedge of clk
	always_ff @(posedge clk)
		if (reset)
			ps <= NONE;  // at reset, go back to None
		else
			ps <= ns; // otherwise, go to the next state, dictated by NS logic
	
endmodule

module towdisplay_testbench();
	logic clk, reset, win2, win1;
	logic [6:0] leds;
	
	towdisplay dut (clk, reset, win2, win1, leds);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);		// !!! you wait for a posedge (and thus FSM)
	reset <= 1; 			  @(posedge clk);		// moves to the next state) before applying
	reset <= 0;            @(posedge clk);		// new inputs
								  @(posedge clk);
	win2 <= 0; win1 <= 0;  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	win1 <= 1;				  @(posedge clk);
	reset <= 1;	win1 <= 0;			  @(posedge clk);
	reset <= 0;								  @(posedge clk);
							  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule