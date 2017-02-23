// Andrique Liu

// FSM: operates the winLights at the ends of the LEDRs
// Reset: winLight turns off
module winLight (clk, reset, L, R, NL, NR, lightOn);
	input logic clk, reset;
	
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
	
	// When player has won, the "light" should be on.
	output logic lightOn;
	
	// State variables.
	// ON, OFF
	enum { OFF, ON } ps, ns;
	
	// Next State Logic
	// Accomodates simultaneous L and R signals
	// Transition from ON to OFF: remains on so neighbor light's
	// NL or NR remains on. Transition from OFF to ON: remains off
	// so lights are not simultaneously on
	always_comb begin
		case (ps)
			ON: begin			// if ON, player has won and game must be reset to play again
//				ns = ON;
				ns = OFF;      // non-default
				lightOn = 1;
			end
			OFF:
				if (((R && NL) || (L && NR)) && (L ^ R)) begin
					ns = ON;
					lightOn = 0;
				end else begin
					ns = OFF;
					lightOn = 0;
				end
		endcase
	end	
	
	// DFFs
	// !!! This means: only execute when you see a posedge of clk
	always_ff @(posedge clk)
		if (reset)
			ps <= OFF;  // at reset, go back to OFF (it's a winLight)
		else
			ps <= ns;   // otherwise, go to the next state, dictated by NS logic

endmodule

// To simulate, you not only have to provide the inputs, but you also
// have to specify the clock, hence the testbench
module winLight_testbench();
	logic clk, reset;
	logic L, R, NL, NR;
	logic lightOn;
	
	winLight dut (clk, reset, L, R, NL, NR, lightOn);
	
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
								  @(posedge clk);
								  @(posedge clk);
	L <= 1;   		  	     @(posedge clk);
	L <= 0; NR <= 1;		  @(posedge clk); // make the DB switch for everything!
								  @(posedge clk);
								  @(posedge clk);
	L <= 1; 			  	     @(posedge clk);
	L <= 0; NR <= 0;		  @(posedge clk); // should be always on from here
								  @(posedge clk);
								  @(posedge clk);
	R <= 1; 			  	     @(posedge clk);
	R <= 0; NR <= 1;		  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	R <= 1; 			  		  @(posedge clk);
	R <= 0; NR <= 0;		  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule