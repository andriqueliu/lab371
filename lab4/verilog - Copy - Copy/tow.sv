// Andrique Liu

// Highest-level module, manages all submodules in
// Tug of War game, Cyber Player Edition.
// Accomodates simultaneous button presses.
// Player 2 is assigned KEY 3, Player 1 is the computer.
// Game ends when either player "pulls" the light into their territory.
// Match ends when either player has won 7 games.
// SW 9 is used to reset the game.
module tow (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  logic 		 CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input  logic [3:0] KEY; // True when not pressed, False when pressed (For the physical board)
	input  logic [9:0] SW;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
//	parameter whichClock = 15;
	parameter whichClock = 15;
	clock_divider cdiv (CLOCK_50, clk);
	
	// try... setting keys to MS version, also
	// comment out main module's clk div and put it inside the testbench
	
	// Turn unused hex displays off
	assign HEX1[6:0] = ~(7'b0000000);
	assign HEX2[6:0] = ~(7'b0000000);
	assign HEX3[6:0] = ~(7'b0000000);
	assign HEX4[6:0] = ~(7'b0000000);
	
	// Declare reset, L, R logic
	logic reset, L, R; // should these be output? no, you'd have to define in ports
							 // just treat them as WIRES. same for win2 and win1!!!
	assign reset = SW[9];
	
	// NEGATION: negate for board, don't negate for MS!!!
	
	// Create random number generator (LFSR with 10 bits)
	logic [9:0] randyout;
	lfsr10b randy (.clk(clk[whichClock]), .reset, .out(randyout));
	
	// Create comparator
	logic sw_g_lfsr;
	comparator comp (.clk(clk[whichClock]), .reset, .a(SW), .b(randyout), .a_g_b(sw_g_lfsr));
	
//	// Board Version
//	uinput ui2 (.clk(clk[whichClock]), .reset, .in(~KEY[3]), .out(L));
//	uinput ui1 (.clk(clk[whichClock]), .reset, .in(sw_g_lfsr), .out(R));
	
	// MS Version
	uinput ui2 (.clk(clk[whichClock]), .reset, .in(KEY[3]), .out(L));
	uinput ui1 (.clk(clk[whichClock]), .reset, .in(sw_g_lfsr), .out(R));
	
	// Declare game and match over logic
	logic gamereset, matchover;
	
	// Hook up light nodes
	normalLight l9 (.clk(clk[whichClock]), .reset, .L, .R, .NL(0), .NR(LEDR[8]), .lightOn(LEDR[9]));
	normalLight l8 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
	normalLight l7 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
	normalLight l6 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
//	centerLight l5 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]));
	centerLight l5 (.clk(clk[whichClock]), .reset, .gamereset, .matchover, .L, .R, .NL(LEDR[6]),
						 .NR(LEDR[4]), .lightOn(LEDR[5]));
	normalLight l4 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
	normalLight l3 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
	normalLight l2 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
	normalLight l1 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[2]), .NR(0), .lightOn(LEDR[1]));

	// Hook up win light FSMs
	logic win2, win1;
	winLight wl2 (.clk(clk[whichClock]), .reset, .L, .R, .NL(0), .NR(LEDR[9]), .lightOn(win2));
	winLight wl1 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[1]), .NR(0), .lightOn(win1));
	
	// Hook up winner behavior modules and counters
	assign gamereset = (win2 || win1);
	
	logic matchwin2, matchwin1;
	counter c2 (.clk(clk[whichClock]), .reset, .gamewin(win2), .matchwin(matchwin2), .leds(HEX5));
	counter c1 (.clk(clk[whichClock]), .reset, .gamewin(win1), .matchwin(matchwin1), .leds(HEX0));
	
	assign matchover = (matchwin2 || matchwin1);   // the logic currently stops the game
																  // once the match is over
	
endmodule

// To simulate, you not only have to provide the inputs, but you also
// have to specify the clock, hence the testbench
module tow_testbench();
	logic 		CLOCK_50; // 50MHz clock.
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed
	logic [9:0] SW;
	
	tow dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	// Test clkdiv
	logic [31:0] clk;
//	parameter whichClock = 15;
	parameter whichClock = 15;
	clock_divider cdiv (CLOCK_50, clk);
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	
								  @(posedge clk[whichClock]);
	SW[9] <= 1;				  @(posedge clk[whichClock]);
	            			  @(posedge clk[whichClock]);
	SW[9] <= 0;				  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
//	KEY[0] <= 0; KEY[3] <= 0;			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	SW[9:0] <= 10'b0111111111;							  @(posedge clk[whichClock]); // set the SW super high, comp. should kill
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
//	KEY[3] <= 1;			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);    // before this is just seeing if it'll move to the right
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
				  				  @(posedge clk[whichClock]);
					  			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 1; KEY [0] <= 1; @(posedge clk[whichClock]); // Simultaneous L and R... good
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 0; KEY [0] <= 0;	@(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);   // By this point, Player 2 has won... 1 game
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
	KEY[3] <= 1;			  @(posedge clk[whichClock]);
	KEY[3] <= 0;			  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);
								  @(posedge clk[whichClock]);	
	
//								  @(posedge CLOCK_50);
//	SW[9] <= 1;				  @(posedge CLOCK_50);
//	            			  @(posedge CLOCK_50);
//	SW[9] <= 0;				  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
////	KEY[0] <= 0; KEY[3] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	SW[9:0] <= 10'b0111111111;							  @(posedge CLOCK_50); // set the SW super high, comp. should kill
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
////	KEY[3] <= 1;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);    // before this is just seeing if it'll move to the right
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//				  				  @(posedge CLOCK_50);
//					  			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 1; KEY [0] <= 1; @(posedge CLOCK_50); // Simultaneous L and R... good
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 0; KEY [0] <= 0;	@(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);   // By this point, Player 2 has won... 1 game
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	SW[9] <= 1;				  @(posedge CLOCK_50);   // Reset
//	SW[9] <= 0;				  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[0] <= 1;			  @(posedge CLOCK_50);
//	KEY[0] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[0] <= 1;			  @(posedge CLOCK_50);
//	KEY[0] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[0] <= 1;			  @(posedge CLOCK_50);
//	KEY[0] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[0] <= 1;			  @(posedge CLOCK_50);
//	KEY[0] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//	KEY[0] <= 1;			  @(posedge CLOCK_50);   // This has Player 1 win
//	KEY[0] <= 0;			  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
//								  @(posedge CLOCK_50);
	$stop; // End the simulation.
	end
endmodule