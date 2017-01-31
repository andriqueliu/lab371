/*
EE 371 Lab 3 Project
Designing an Underwater Digital Scanning System
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

scanner


Note: Assume we are using 25 MHz clock (whichClock = 0)


*/
module scanner (clk, reset, );
	input  logic clk, reset;
	input  logic 
	
	output logic 
	
	
	
	
	dataBuffer dataBuff (.clk, .reset, .level80(), .level90(), .level100());
	
	
	enum { LOWPOWER, STANDBY, ACTIVE, IDLE } ps, ns;
	
	
	// Combinational Logic
	always_comb begin
		
	end
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			
		end else begin
			ps <= ns;
		end
	end
	
endmodule
