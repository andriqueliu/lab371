// EE 371
// Andrique Liu, Emraj Sidhu, Nikhil Grover
// The Transfer station

// Will in take clk from the scanner. Other inputs will be the reset and the 8 bit
// input from the scanner. The output will be an 8 bit signal
// The ready signal still needs to be implemented

module transfer(clk, reset, data_scanner, out_data, ready);
	input logic clk, reset;
	input logic data_scanner; // Will take one bit input at a time
	//output logic [7:0] out_data;
	output logic [1:0] ready;
	
	reg [7:0] bits1; //Will be used to count each bit at every positive clock edge
	
	
	// This will look at every bit passed in and will continue going until 8 bits have been 
	// input. 
	always @(posedge clk) begin
		if (reset)
			begin
				bits1 <= 8'b00000000;
		   end
		else 
			begin
				bits1[0] <= data_scanner;
				bits1[1] <= bits1[0];
				bits1[2] <= bits1[1];
				bits1[3] <= bits1[2];
				bits1[4] <= bits1[3];
				bits1[5] <= bits1[4];
				bits1[6] <= bits1[5];
				bits1[7] <= bits1[6];
			end
	end
	

		//assign out_data = bits1; //assign the output to the 8 bit signal

endmodule