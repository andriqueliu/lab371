/*
EE 371 Lab 2 Project
Nikhil Grover, Andrique Liu, Emraj Sidhu

gate functions as a gate in the Pound Lock system.

gate's output indicates whether the gate is open or closed; an active
gateClosed signal indicates the gate is open (gondola is free to pass),
and a clear signal indicates the gate is closed.

Note: In a higher level module, let this gateOpen signal strobe an LED low to
indicate the gate has been opened.
^ !!! We probably want to run at a slightly slower clock so that we can
actually see the strobing... 
*/

module gate(clk, reset, openSignal, gateOpen);
	input  logic clk, reset; // Clock, reset signals
	input  logic openSignal; // Signal to open the gate
	output logic gateOpen;   // Is the gate open?
	
	// State variables
	enum { OPEN, CLOSED } ps, ns;
	
	// Combinational Logic
	always_comb begin
		case (ps)
			CLOSED: begin
				if (openSignal) begin
					ns = OPEN;
					gateOpen = 1;
				end else begin
					ns = CLOSED;
					gateOpen = 0;
				end
			end
			
			OPEN: begin
				ns = CLOSED;
				gateOpen = 0;
			end
		endcase
	end
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if(reset)
			ps <= CLOSED; // Reset to closed
		else
			ps <= ns;
	end
	
endmodule
