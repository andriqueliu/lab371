/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

PoundLock is the highest level module in the system, and manages all modules in the
design. PoundLock interfaces with board peripherals, routing signals into the system's
modules.
*/
module PoundLock (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  logic 		 CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input  logic [3:0] KEY; // True when not pressed, False when pressed (For the physical board)
	input  logic [9:0] SW;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
//	parameter whichClock = 15;
	parameter whichClock = 0;
	clock_divider cdiv (CLOCK_50, clk);
	
	// try... setting keys to MS version, also
	// comment out main module's clk div and put it inside the testbench
	
	// Turn unused hex displays off
	assign HEX1[6:0] = ~(7'b0000000);
	assign HEX2[6:0] = ~(7'b0000000);
	assign HEX3[6:0] = ~(7'b0000000);
	assign HEX4[6:0] = ~(7'b0000000);
	assign HEX5[6:0] = ~(7'b0000000);
	assign HEX6[6:0] = ~(7'b0000000);
	
	// Declare reset, logic 
	logic reset;
	logic increase, decrease;
	logic arriving, departing, gateR, gateL;
	logic inL, inR, inChamber;
	
	assign arriving  = SW[0];
	assign departing = SW[1];
	
	// NEGATION: negate for board, don't negate for MS!!!
	
	// Intermediate signals: busy flags and enables
	logic increaseBusy, decreaseBusy, arrivalBusy;
	logic increaseEn, decreaseEn, arrivalEn;
	
	// Hook up delayed input modules
	delayInput incDelay (.clk(clk[whichClock]), .reset, .start(increase),
	                     .enable(increaseEn), .busy(increaseBusy));
	delayInput decDelay (.clk(clk[whichClock]), .reset, .start(decrease),
	                     .enable(decreaseEn), .busy(decreaseBusy));
	
	// Hook up user input modules (filter out metastability and also debounce)
	uinput ui0 (.clk(clk[whichClock]), .reset, .in(~KEY[0]), .out(reset));
	uinput ui1 (.clk(clk[whichClock]), .reset, .in(~KEY[1]), .out(increase));
	uinput ui2 (.clk(clk[whichClock]), .reset, .in(~KEY[2]), .out(decrease));
	uinput ui5 (.clk(clk[whichClock]), .reset, .in(SW[2]), .out(gateR));
	uinput ui6 (.clk(clk[whichClock]), .reset, .in(SW[3]), .out(gateL));
	
	// Indicate gate status
	assign LEDR[2] = gateR;
	assign LEDR[3] = gateL;
	
	// Hook up input module to board peripherals and intermediate signals
	inputModule inMod (.clk(clk[whichClock]), .reset, .arriving(arriving), .departing,
	             .arrivingOut(LEDR[0]), .departingOut(LEDR[1]),
                .gateR, .gateL,
					 .gondInRLEDR(LEDR[7]), .gondInLLEDR(LEDR[9]), .gondInChamberLEDR(LEDR[8]),
					 .increaseEnable(increaseEn), .decreaseEnable(decreaseEn), .arrivingEnable(1'b0),
					 .increaseBusy(1'b0), .decreaseBusy(1'b0), .arrivingBusy(1'b0),
					 .leftGood(LEDR[5]), .rightGood(LEDR[4]));	
	
endmodule

// To simulate, you not only have to provide the inputs, but you also
// have to specify the clock, hence the testbench
module PoundLock_testbench();
	logic 		CLOCK_50; // 50MHz clock.
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed
	logic [9:0] SW;
	
	PoundLock dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
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