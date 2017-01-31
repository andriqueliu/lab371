/*
EE 371 Lab 3 Project
Designing an Underwater Digital Scanning System
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

dataBuffer 

Note: Assume we are using 25 MHz clock (whichClock = 0)

Note: Since Quartus does not allow floats, int bufferAmount goes up to 20 in
increments of 1 instead of up to 10 in increments of 0.5.
*/
module dataBuffer (clk, reset, );
	input  logic clk, reset;
	input  logic 
	
	output logic 
	
	int count;
	int bufferAmount;
	
	initial begin
		count = 0;
		bufferAmount = 0;
	end
	
	// Combinational Logic
	always_comb begin
		
	end
	
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			count <= 0;
			bufferAmount <= 0;
		end else if () begin
			
		end
	end
	
	
endmodule
