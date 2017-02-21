// Andrique Liu

// 
module towwin (clk, reset, win2, win1, hex2, hex1, hex2);
	input  logic 		 clk, reset;
	input  logic       win2, win1;   // input from winLight nodes
	output logic [6:0] hex2, hex1;   // from higher module, connect the OG 
												// hexes here
	
	
	// Standby, and Player 2 and Player 1 victory states
	enum { WAIT, P1, P2 } ps, ns;

	counter count2 (.clk, .reset, .gamewin(win2), .matchwin(hex2));
	counter count1 (.clk, .reset, .gamewin(win1), .matchwin(hex1));
	
	always_comb begin		
		case (ps)
			WAIT: begin
				if (win2) 
			end
			P1: begin   // Player 1 has won. End game
				
			end
			P2: begin   // Player 2 has won. End game
				
			end
//			default:
		endcase
		
		
	end
		
	// DFFs
	// !!! This means: only execute when you see a posedge of clk
	always_ff @(posedge clk)
		if (reset)
			ps <= WAIT;  // at reset, go back to None
		else
			ps <= ns; // otherwise, go to the next state, dictated by NS logic
	
endmodule

module towwin_testbench();
	logic clk, reset, win2, win1;
	logic [6:0] leds1, leds2;
	
	towwin dut (clk, reset, win2, win1, leds1, leds2);
	
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