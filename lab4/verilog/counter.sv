// Andrique Liu

// Counter module: increments player score when he or she wins
module counter (clk, reset, gamewin, matchwin, leds);   // !!! Can use an FSM as a counter
	input  logic 		 clk, reset;
	input  logic       gamewin;
	output logic		 matchwin;
	
	output logic [6:0] leds;   // keep an eye on this!!! hooks up to OG hex // !!! change to the display arrives one cycle after the change in LED... good?
	logic        [2:0] bcd;    // and also this
	
	// Hook up seg7 submodule
	seg7 display (.bcd, .leds);
	
	enum { ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN } ps, ns;
	
	always_comb begin
		case (ps)
			ZERO: begin
				bcd = 3'b000;
				if (gamewin) ns = ONE;
				else ns = ZERO;
			end
			ONE: begin
				bcd = 3'b001;
				if (gamewin) ns = TWO;
				else ns = ONE;
			end
			TWO: begin
				bcd = 3'b010;
				if (gamewin) ns = THREE;
				else ns = TWO;
			end
			THREE: begin
				bcd = 3'b011;
				if (gamewin) ns = FOUR;
				else ns = THREE;
			end
			FOUR: begin
				bcd = 3'b100;
				if (gamewin) ns = FIVE;
				else ns = FOUR;
			end
			FIVE: begin
				bcd = 3'b101;
				if (gamewin) ns = SIX;
				else ns = FIVE;
			end
			SIX: begin
				bcd = 3'b110;
				if (gamewin) ns = SEVEN;
				else ns = SIX;
			end
			SEVEN: begin   // By this point, the player has won
				bcd = 3'b111;
				ns = SEVEN; // Keep cycling back to SEVEN until player resets
				
				// logic to "freeze" the game!!!
			end
		endcase
		
		if (ps == SEVEN) matchwin = 1;   // !!! Watch: ps or ns
		else matchwin = 0;
	end
		
	// DFFs
	// !!! This means: only execute when you see a posedge of clk
	always_ff @(posedge clk)
		if (reset)
			ps <= ZERO;  // at reset, go back to None
		else
			ps <= ns; // otherwise, go to the next state, dictated by NS logic
	
endmodule

module counter_testbench();
	logic       clk, reset;
	logic       gamewin, matchwin;
	logic [6:0] leds;
	
	counter dut (clk, reset, gamewin, matchwin, leds);
	
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
//	gamewin <= 1;			  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);   // !!! Debouncer is required, so in higher
	gamewin <= 0;			  @(posedge clk);   // module, only send gamewin for one cycle
								  @(posedge clk);
								  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);
	gamewin <= 0;			  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);
	gamewin <= 0;			  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);
	gamewin <= 0;			  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);   // 5
	gamewin <= 0;			  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);
	gamewin <= 0;			  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);   // 7
	gamewin <= 0;			  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	gamewin <= 1;			  @(posedge clk);
	gamewin <= 0;			  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule