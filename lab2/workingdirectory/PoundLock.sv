// EE 371 Lab 2 Project: Pound Lock System
// Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu
// 
// Highest-level module, manages all submodules in Pound Lock system.
// Accomodates simultaneous button presses.
// 
// SW 9 is used to reset the game.
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
	
	// Declare reset, logic 
	logic reset;
	logic increase, decrease;
	logic arriving, departing, gateR, gateL;
	logic inL, inR, inChamber;
	
	assign arriving  = SW[0];
	assign departing = SW[1];
	
	// NEGATION: negate for board, don't negate for MS!!!
	
	// Try without delay input first... 
	
	logic increaseBusy, decreaseBusy, arrivalBusy;
	logic increaseEn, decreaseEn, arrivalEn;
	
	
	delayInput incDelay (.clk(clk[whichClock]), .reset, .start(increase),
	                     .enable(increaseEn), .busy(increaseBusy));
	delayInput decDelay (.clk(clk[whichClock]), .reset, .start(decrease),
	                     .enable(decreaseEn), .busy(decreaseBusy));
//	delayInput arrDelay (.clk(clk[whichClock]), .reset, .start(arriving),
//	                     .enable(arrivalEn), .busy(arrivalBusy));
	delayInputArrival arrDelay (.clk(clk[whichClock]), .reset, .start(arriving),
	                     .enable(arrivalEn), .busy(arrivalBusy));
	
	// Board Version
	uinput ui0 (.clk(clk[whichClock]), .reset, .in(~KEY[0]), .out(reset));
	uinput ui1 (.clk(clk[whichClock]), .reset, .in(~KEY[1]), .out(increase));
	uinput ui2 (.clk(clk[whichClock]), .reset, .in(~KEY[2]), .out(decrease));
//	uinput ui3 (.clk(clk[whichClock]), .reset, .in(SW[0]), .out(arriving));
//	uinput ui4 (.clk(clk[whichClock]), .reset, .in(SW[1]), .out(departing));
	uinput ui5 (.clk(clk[whichClock]), .reset, .in(SW[2]), .out(gateR));
	uinput ui6 (.clk(clk[whichClock]), .reset, .in(SW[3]), .out(gateL));
	
	assign LEDR[2] = gateR;
	assign LEDR[3] = gateL;
	
	inputModule inMod (.clk(clk[whichClock]), .reset, .arriving(arriving), .departing,
	             .arrivingOut(LEDR[0]), .departingOut(LEDR[1]),
                .gateR, .gateL,
					 .gondInRLEDR(LEDR[7]), .gondInLLEDR(LEDR[9]), .gondInChamberLEDR(LEDR[8]),
					 .increaseEnable(increaseEn), .decreaseEnable(decreaseEn), .arrivingEnable(1'b0),
					 .increaseBusy(1'b0), .decreaseBusy(1'b0), .arrivingBusy(1'b0),
					 .leftGood(LEDR[5]), .rightGood(LEDR[4]));
//					 .gateRClosed(LEDR[2]), .gateLClosed(LEDR[3]));
	
	// MS Version
//	uinput ui2 (.clk(clk[whichClock]), .reset, .in(KEY[3]), .out(L));
//	uinput ui1 (.clk(clk[whichClock]), .reset, .in(sw_g_lfsr), .out(R));
	
	
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