/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

inputModule regulates the inputs to the system. For instance, this module filters out
irrelevant commands (example: arrival signal cannot be sent while the gondola is in
the chamber), and also ignores other commands while other inputs are being processed.
*/
module inputModule (clk, reset, arriving, departing, arrivingOut, departingOut,
                    gateR, gateL,
						  gondInRLEDR, gondInLLEDR, gondInChamberLEDR,
						  increaseEnable, decreaseEnable, arrivingEnable,
						  increaseBusy, decreaseBusy, arrivingBusy,
						  leftGood, rightGood);
	input  logic clk, reset;                // Clock, reset signal
	input  logic arriving, departing;       // Arriving, departing signals
	output logic arrivingOut, departingOut; // Indicates whether gond. is arriving or departing
	input  logic gateR, gateL;              // Open/close left and right gates
	logic  gateROut, gateLOut;              // Intermediate signal; open/close signals
	
	// Signals from lockSystem:
	logic gondInRIn, gondInLIn, gondInChamberIn; // Location of the gondola
	// Location of the gondola LEDR indicator
	output logic gondInRLEDR, gondInLLEDR, gondInChamberLEDR;
	// Increase/decrease signals
	input  logic increaseEnable, decreaseEnable, arrivingEnable;
	logic increaseEnableOut, decreaseEnableOut, arrivingEnableOut;
	// Busy flags
	input  logic increaseBusy, decreaseBusy, arrivingBusy;
	
	// Input buffer: ignore inputs if any busy flag is set, allow them otherwise.
	// Note: reset is NOT filtered; propagates throughout entire design if it has to.
	// Note: other input signals that do not affect execution of the design are also
	// not filtered, such as: gondInL, R, Chamber.
	logic arrivingBuffer, departingBuffer, gateRBuffer, gateLBuffer;
	logic increaseEnableBuffer, decreaseEnableBuffer;
	
	// Indicates whether the right and left gate have appropriate water differentials.
	output logic leftGood, rightGood;
	
	// Intermediate signals; connects gondola location indicators.
	logic gondL;
	logic gondR;
	logic gondCh;
	
	// Filter out and assign signals:
	// Filter and assign arrival, departing indicators 
	assign arrivingOut = (arrivingBuffer && (gondL || gondR));
	assign departingOut = (departingBuffer && gondCh);
	
	// Assign gondola LEDR indicators to their inputs
	assign gondInRLEDR = gondR;
	assign gondInLLEDR = gondL;
	assign gondInChamberLEDR = gondCh;
	// Filter and assign gate open/close signals
	assign gateROut = (gateRBuffer && ((arrivingBuffer && gondR) ||
                     (departingBuffer && gondCh)));
	assign gateLOut = (gateLBuffer && ((arrivingBuffer && gondL) ||
                     (departingBuffer && gondCh)));
	
	// Dummy signals; Placeholders
	logic [1:0] dummy;
	
	// Hook up signals to lockSystem
	lockSystem lockSys (.clk, .reset,
	                    .increase(increaseEnableBuffer), .decrease(decreaseEnableBuffer),
               	     .gateR(gateROut), .gateL(gateLOut),
                       .gondInL(gondL), .gondInChamber(gondCh), .gondInR(gondR),
						     .gateRClosed(dummy[0]), .gateLClosed(dummy[1]),
							  .leftGo(leftGood), .rightGo(rightGood));
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (increaseBusy || decreaseBusy || arrivingBusy) begin
			arrivingBuffer = 1'b0;
			departingBuffer = 1'b0;
			gateRBuffer = 1'b0;
			gateLBuffer = 1'b0;
			increaseEnableBuffer = 1'b0;
			decreaseEnableBuffer = 1'b0;
		end else begin
			arrivingBuffer = arriving;
			departingBuffer = departing;
			gateRBuffer = gateR;
			gateLBuffer = gateL;
			increaseEnableBuffer = increaseEnable;
			decreaseEnableBuffer = decreaseEnable;
		end
	end
	
endmodule

//module inputModule_testbench();
//	logic clk, reset;          // Clock, reset signal
//	logic arriving, departing; // Arriving, departing signals
//	logic arrivingOut, departingOut;
//	logic gateR, gateL;        // Open/close left and right gates
//	logic gateROut, gateLOut;  
//	
//	// Signals from lockSystem
//	logic gondInRIn, gondInLIn, gondInChamberIn; // Location of the gondola
//	// Location of the gondola LEDR indicator
//	logic gondInRLEDR, gondInLLEDR, gondInChamberLEDR;
//	// Increase/decrease signals
//	logic increaseEnable, decreaseEnable, arrivingEnable;
//	logic increaseEnableOut, decreaseEnableOut, arrivingEnableOut;
//	logic increaseBusy, decreaseBusy, arrivingBusy;
//	
//	inputModule dut (clk, reset, arriving, departing, arrivingOut, departingOut,
//                    gateR, gateL, gateROut, gateLOut, gondInRIn, gondInLIn, gondInChamberIn,
//						  gondInRLEDR, gondInLLEDR, gondInChamberLEDR,
//						  increaseEnable, decreaseEnable, arrivingEnable,
//						  increaseEnableOut, decreaseEnableOut, arrivingEnableOut,
//						  increaseBusy, decreaseBusy, arrivingBusy);
//	
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	initial begin
//								  @(posedge clk);
//	reset <= 1; 			  @(posedge clk);
//								  @(posedge clk);
//	reset <= 0;            @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	arriving <= 1;         @(posedge clk);
//								  @(posedge clk);
//	gateR <= 1;            @(posedge clk);
////	decreaseEnable <= 1;   @(posedge clk);
////	decreaseEnable <= 0;   @(posedge clk);
//								  @(posedge clk);
////	gateR <= 1;            @(posedge clk);
////	gateR <= 0;            @(posedge clk);
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
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	$stop; // End the simulation.
//	end
//endmodule
