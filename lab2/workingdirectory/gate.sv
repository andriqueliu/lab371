// EE 371 Lab 2 Project
// gate is a lower level module that dictates whether a gondola may cross
// Authors: Andrique Liu, Emraj Sidhu, Nikhil Grover

/*
gate functions as a gate in the Pound Lock system.

gate's output indicates whether the gate is open or closed; an active
gateClosed signal indicates the gate is open (gondola is free to pass),
and a clear signal indicates the gate is closed.
*/
module gate(clk, reset, openCase, open);
	input  logic clk, reset; // Clock, reset signals
	input  logic openSignal; // Signal to open the gate
	output logic gateOpen;   // Is the gate open?
	
	//State variables
	enum { OPEN, CLOSED } ps, ns;
	
	// Combinational Logic
	always_comb begin
		case (ps)
			OPEN:
				if(!openCase) begin
					ns = CLOSE;
					open = 0;
				end else begin
					ns = OPEN;
					open = 1;
				end
			CLOSED:
				if(!openCase) begin
					ns = CLOSE;
					open = 0;
				end else begin
					ns = OPEN;
					open = 1;
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
