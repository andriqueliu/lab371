/*
EE 371 Lab 3 Project
Designing an Underwater Digital Scanning System
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

scanner


Note: Assume we are using 25 MHz clock (whichClock = 0)


*/
module scanner (clk, reset, );
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
		if (bufferAmount == 16) begin
			level80 = 1;
			level90 = 0;
			level100 = 0;
		end else if (bufferAmount == 18) begin
			level80 = 0;
			level90 = 1;
			level100 = 0;
		end else if (bufferAmount == 20) begin
			level80 = 0;
			level90 = 0;
			level100 = 1;
		end else begin
			level80 = 0;
			level90 = 0;
			level100 = 0;
		end
	end
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			count <= 0;
			bufferAmount <= 0;
		end else if (count == (25000000 - 1)) begin // Probably want a smaller value for testing in MS
			count <= 0;
			bufferAmount <= bufferAmount + 1;
		end else begin
			count <= count + 1;
		end
	end
	
endmodule
