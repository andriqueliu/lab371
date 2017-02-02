/*
EE 371 Lab 3 Project
Designing an Underwater Digital Scanning System
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

dataBuffer controls the data level of the data buffer. 


Note: Assume we are using 25 MHz clock (whichClock = 0)


*/
module dataBuffer (clk, reset, level80, level90, level100);
	input  logic clk, reset;
	
	output logic level80, level90, level100;
	
	int count;
	int bufferAmount;
	
	initial begin
		count = 0;
		bufferAmount = 0;
	end
	
	// Combinational Logic
	always_comb begin
		if (bufferAmount == 8) begin
			level80 = 1;
			level90 = 0;
			level100 = 0;
		end else if (bufferAmount == 9) begin
			level80 = 0;
			level90 = 1;
			level100 = 0;
		end else if (bufferAmount == 10) begin
			level80 = 0;
			level90 = 0;
			level100 = 1;
		end else begin
			level80 = 0;
			level90 = 0;
			level100 = 0;
		end
	end
	
	// Seq Log needs testing
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			count <= 0;
			bufferAmount <= 0;
		end else if ((count == (25000000 - 1)) && (bufferAmount <= 9)) begin
			count <= 0;
			bufferAmount <= bufferAmount + 1;
		end else begin
			count <= count + 1;
		end
	end
	
endmodule
