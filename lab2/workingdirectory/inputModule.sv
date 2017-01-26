/*
EE 371 Lab 2 Project
Andrique Liu, Nikhil Grover, Emraj Sidhu

inputModule regulates the inputs to the system. For instance, this module filters out
irrelevant commands (example: arrival signal cannot be sent while the gondola is in
the chamber), and also ignores other commands while a delayed command is being executed.

Delayed input commands: arrival, increase, decrease



*/
module inputModule ();
	input  logic clk, reset;
	input  logic arriving, departing;
	input  logic gateR, gateL;
	
	// Signals from lockSystem
//	input  logic gondInR, gondInL, gondInChamber; // Location of the gondola
	output logic gondInR, gondInL, gondInChamber; // Location of the gondola
	
//	input  logic increaseEnable, decreaseEnable, arrivingEnable;
	input  logic increaseBusy, decreaseBusy, arrivingBusy;
	
	// Intermediate signals
	logic increaseEnable, decreaseEnable, arrivingEnable; // This connects to... 
	
	
	// Input buffer: ignore inputs if any busy flag is set, allow them otherwise.
	// Note: reset is NOT filtered; propagates throughout entire design if it has to.
	// Note: other input signals that do not affect execution of the design are also
	// not filtered, such as: gondInL, R, Chamber. 
	// Filtered signals: 
	logic [] inputBuffer;
	assign inputbuffer [] = ;
	
	lockSystem lockSys (.clk, .reset, .increase, .decrease, .gateR, .gateL,
                       .gondInL, .gondInChamber, .gondInR,
						     .gateRClosed, .gateLClosed);
	
	// Combinational Logic
	always_comb begin
		// If there is a set busy flag anywhere, all inputs are ignored
		if (increaseBusy || decreaseBusy || arrivingBusy) begin
			// Set intermediate logic variables (make new ones) all to 0
			inputBuffer & // bunch of 0s
		end else begin // Else, if no busy flag, take inputs 
			inputBuffer & // bunch of 1s; does nothing
		end
		
	end
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			
		end else begin
			
		end
	end
	
endmodule
