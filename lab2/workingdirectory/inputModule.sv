/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

inputModule regulates the inputs to the system. For instance, this module filters out
irrelevant commands (example: arrival signal cannot be sent while the gondola is in
the chamber), and also ignores other commands while a delayed command is being executed.

Delayed input commands: arrival, increase, decrease



*/
module inputModule (clk, reset, arriving, departing, arrivingOut, departingOut,
                    gateR, gateL, gateROut, gateLOut, gondInR, gondInL, gondInChamber,
						  gondInRLEDR, gondInLLEDR, gondInChamberLEDR,
						  increaseEnable, decreaseEnable, arrivingEnable,
						  increaseEnableOut, decreaseEnableOut, arrivingEnableOut,
						  increaseBusy, decreaseBusy, arrivingBusy);
	input  logic clk, reset; // Clock, reset signal
	input  logic arriving, departing; // Arriving, departing signals
	output logic arrivingOut, departingOut;
	input  logic gateR, gateL; // Open/close left and right gates
	output logic gateROut, gateLOut;
	
	// Signals from lockSystem
	input  logic gondInR, gondInL, gondInChamber; // Location of the gondola
	// Location of the gondola LEDR indicator
	output logic gondInRLEDR, gondInLLEDR, gondInChamberLEDR;
	// Increase/decrease signals
	input  logic increaseEnable, decreaseEnable, arrivingEnable;
	output logic increaseEnableOut, decreaseEnableOut, arrivingEnableOut;
	input  logic increaseBusy, decreaseBusy, arrivingBusy;	
	
	// Input buffer: ignore inputs if any busy flag is set, allow them otherwise.
	// Note: reset is NOT filtered; propagates throughout entire design if it has to.
	// Note: other input signals that do not affect execution of the design are also
	// not filtered, such as: gondInL, R, Chamber.
	logic arrivingBuffer, departingBuffer, gateRBuffer, gateLBuffer;
	logic increaseEnableBuffer, decreaseEnableBuffer;
	
	assign arrivingBuffer = arriving;
	assign departingBuffer = departing;
	assign gateRBuffer = gateR;
	assign gateLBuffer = gateL;
	assign increaseEnableBuffer = increaseEnable;
	assign decreaseEnableBuffer = decreaseEnable;
	
	// Filter out and assign signals:
	// Filter and assign arrival, departing indicators 
	assign arrivingOut = (arrivingBuffer && gondInL || gondInR);
	assign departingOut = (departingBuffer && gondInChamber);
	// Assign gondola LEDR indicators to their inputs
	assign gondInRLEDR = gondInR;
	assign gondInLLEDR = gondInL;
	assign gondInChamberLEDR = gondInChamber;
	// Filter and assign gate open/close signals
	assign gateROut = (gateRBuffer && ((arrivingBuffer && gondInR) ||
                     (departingBuffer && gondInChamber)));
	assign gateLOut = (gateLBuffer && ((arrivingBuffer && gondInL) ||
                     (departingBuffer && gondInChamber)));
	// Assign delayed output enables
	assign increaseEnableOut = increaseEnableBuffer;
	assign decreaseEnableOut = decreaseEnableBuffer;
	assign arrivingEnableOut = arrivingBuffer;
	
	
//	logic [] inputBuffer;
//	assign inputbuffer [] = ;
	logic [1:0] dummy;
	
	lockSystem lockSys (.clk, .reset,
	                    .increase(increaseEnableOut), .decrease(decreaseEnableOut),
               	     .gateR(gateROut), .gateL(gateLOut),
                       .gondInL(gondInL), .gondInChamber, .gondInR,
						     .gateRClosed(dummy[0]), .gateLClosed(dummy[1]));
//							  .gateRClosed(), .gateLClosed);
	
//	// Combinational Logic
//	always_comb begin
//		// If there is a set busy flag anywhere, all inputs are ignored
//		if (increaseBusy || decreaseBusy || arrivingBusy) begin
//			// Set intermediate logic variables (make new ones) all to 0
//			arrivingBuffer = arrivingBuffer & 0;
//			departingBuffer = departingBuffer & 0;
//			gateRBuffer = gateRBuffer & 0;
//			gateLBuffer = gateLBuffer & 0;
//			increaseEnableBuffer = increaseEnableBuffer & 0;
//			decreaseEnableBuffer = decreaseEnableBuffer & 0;
//		end else begin // Else, if no busy flag, take inputs 
//			arrivingBuffer = arrivingBuffer & 1;
//			departingBuffer = departingBuffer & 1;
//			gateRBuffer = gateRBuffer & 1;
//			gateLBuffer = gateLBuffer & 1;
//			increaseEnableBuffer = increaseEnableBuffer & 1;
//			decreaseEnableBuffer = decreaseEnableBuffer & 1;
//		end
//	end
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (increaseBusy || decreaseBusy || arrivingBusy) begin
			arrivingBuffer = arrivingBuffer & 1'b0;
			departingBuffer = departingBuffer & 1'b0;
			gateRBuffer = gateRBuffer & 1'b0;
			gateLBuffer = gateLBuffer & 1'b0;
			increaseEnableBuffer = increaseEnableBuffer & 1'b0;
			decreaseEnableBuffer = decreaseEnableBuffer & 1'b0;
		end else begin
			arrivingBuffer = arrivingBuffer & 1'b1;
			departingBuffer = departingBuffer & 1'b1;
			gateRBuffer = gateRBuffer & 1'b1;
			gateLBuffer = gateLBuffer & 1'b1;
			increaseEnableBuffer = increaseEnableBuffer & 1'b1;
			decreaseEnableBuffer = decreaseEnableBuffer & 1'b1;
		end
	end
	
endmodule
