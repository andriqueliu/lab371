// Andrique Liu

// FSM: operates the center light
// Reset: centerLight turns ON
module centerLight (clk, reset, gamereset, matchover, L, R, NL, NR, lightOn);
	input gamereset;
	input matchover;
	
	input logic clk, reset;
	
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
	
	// when lightOn is true, the center light should be on.
	output logic lightOn;
	
	// State variables.
	// ON, OFF
	enum { ON, OFF } ps, ns;
	
	// Next State Logic
	// Accomodates simultaneous L and R signals
	// Transition from ON to OFF: remains on so neighbor light's
	// NL or NR remains on. Transition from OFF to ON: remains off
	// so lights are not simultaneously on
	always_comb begin
		case (ps)
			ON:
				if (L ^ R) begin
					ns = OFF;
					lightOn = 1;
				end else begin
					ns = ON;
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
		
	// Block only executes when it sees a posedge of clk
	always_ff @(posedge clk)
		if (reset || gamereset)
			ps <= ON;  // at reset, go back to ON (it's a centerLight)
		else if (matchover)
			ps <= OFF;
		else
			ps <= ns;  // otherwise, go to the next state, dictated by NS logic
//	always_ff @(posedge clk)
//		if (reset || gamereset)
//			ps <= ON;  // at reset, go back to ON (it's a centerLight)
//		else
//			ps <= ns;  // otherwise, go to the next state, dictated by NS logic

endmodule

module centerLight_testbench();
	logic clk, reset;
	logic L, R, NL, NR;
	logic lightOn;
	logic gamereset;
	logic matchover;
	
	centerLight dut (clk, reset, gamereset, matchover, L, R, NL, NR, lightOn);
	
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
	NL <= 0; NR <= 0; L <= 0; R <= 0;
								  @(posedge clk);
	L <= 1;   		  		  @(posedge clk);
	L <= 0; NL <= 1;	     @(posedge clk); // make the DB switch for everything!
								  @(posedge clk);
								  @(posedge clk);
	L <= 1; 			  		  @(posedge clk);
	L <= 0; NL <= 0;		  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	R <= 1; 			  		  @(posedge clk);
	R <= 0; NL <= 1;		  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	R <= 1; 			  		  @(posedge clk);
	R <= 0; NL <= 0;		  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule