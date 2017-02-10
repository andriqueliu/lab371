// EE 371
// Andrique Liu, Emraj Sidhu, Nikhil Grover
// The Transfer station

// Will in take clk from the scanner. Other input will be the bit
// data from the scanner.

//Reset is included but not needed

// When testing, the first positive clock edge will occur at i = 1 instead of i = 0.
// Because of this, the iterator goes i = 8 instead of i = 7 since 
// we will read 8 bits at a time.


module transfer(clk, reset, data_scanner, ready);
	input logic clk, reset;
	input logic data_scanner; 
	output reg ready;
	
	reg [7:0] bits1; //Will be used to count each bit at every positive clock edge
	
	integer i;
	
	initial begin
		i = 0;
	end
	
	
	// This will look at every bit passed in and will continue going until 8 bits have been 
	// input. 
	always @(posedge clk) begin
		if ( i >= 0 && i < 8) 
			begin
				bits1[i] <= data_scanner;
				i <= i + 1;
				ready <= 1;
			end
		else if ( i >= 7) 
			begin
				i <= 0;
				ready <= 0;
				bits1 <= 8'bXXXXXXXX;
			end
	end
	


		
endmodule 

module transfer_testbench();
	logic clk, reset;
   logic data_scanner;
	logic ready;

	transfer dut(.clk, .reset, .data_scanner, .ready);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
				 data_scanner <= 1;	   @(posedge clk); 
             data_scanner <= 0;		@(posedge clk); 
             data_scanner <= 1;     @(posedge clk);
      		 data_scanner <= 0; 		@(posedge clk);
												@(posedge clk);
												@(posedge clk);
				 data_scanner <= 1;		@(posedge clk);
             					         @(posedge clk);
 												@(posedge clk); 
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
            					         @(posedge clk);
				data_scanner <= 0;	   @(posedge clk); 
				data_scanner <= 1;	   @(posedge clk);
												@(posedge clk);
												@(posedge clk);
                     					@(posedge clk);
												@(posedge clk); 
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
            								@(posedge clk); 
                                 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk); 
                     					@(posedge clk);
                     					@(posedge clk);
												@(posedge clk);
 												@(posedge clk);
												@(posedge clk);
												@(posedge clk); 
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
 $stop; // End the simulation.
												
											
	end

endmodule


