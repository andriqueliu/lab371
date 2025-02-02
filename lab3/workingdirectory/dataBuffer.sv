/*
EE 371 Lab 3 Project
Designing an Underwater Digital Scanning System
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

dataBuffer controls the data level of the data buffer. 


Note: Assume we are using 25 MHz clock (whichClock = 0)


*/
module dataBuffer #(parameter DELAY=25000000) (clk, reset, beginScanning, bufferCleared,
                   level80, level90, level100, bufferAmount);
	input  logic clk, reset;
	input  logic beginScanning;
	input  logic bufferCleared;
	
	output logic level80, level90, level100;
	output integer bufferAmount; // 
	
	integer count;
//	integer bufferAmount;
	
	initial begin
		count = -1;
		bufferAmount = 0;
	end
	
	// Combinational Logic
	// 
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
	
	// Sequential Logic
	// 
	always_ff @(posedge clk) begin
		if (reset || bufferCleared) begin // ??? Can these conditions be paired?
			count <= -1;
			bufferAmount <= 0;
		end else if ((count == -1) && beginScanning) begin
			count <= 0;
		end else if ((count == (DELAY - 1)) && (bufferAmount <= 9)) begin
			count <= 0;
			bufferAmount <= bufferAmount + 1;
		end else if (count >= 0) begin
			count <= count + 1;
		end
	end
	
endmodule

// Test module
module dataBuffer_testbench();
	logic clk, reset;
	logic beginScanning;
	logic bufferCleared;
	
	logic level80, level90, level100;
	integer bufferAmount;
	
	// Called with shorter delay for ease of testing
	dataBuffer #(.DELAY(8)) dut (clk, reset, beginScanning, bufferCleared,
	                             level80, level90, level100, bufferAmount);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	reset <= 1; 			  @(posedge clk);
								  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	beginScanning <= 1;    @(posedge clk);
//	beginScanning <= 0;    @(posedge clk);
	repeat (100) @(posedge clk);
	
								  @(posedge clk);
								  @(posedge clk);
//	beginScanning <= 1;    @(posedge clk);
//	beginScanning <= 0;    @(posedge clk);
//	repeat (100) @(posedge clk);
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
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
