/*
EE 371 Winter 2017
Lab 3 Project
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu



*/
module dataCollector (clk, reset, startScanning, displayData);
	input  logic clk, reset; 
	input  logic startScanning;
	
	output logic [7:0] displayData; // Display data being collected
	
	// 8-bit data buffer with a depth of 1000
	// Depth of 
	logic  [7:0] dataBuffer [1000];
	// 8-bit data that represents scanned data to be inserted into
	// the data buffer
	logic  [7:0] data;
	// scanningActive acts as a boolean; if true, scanner is active and is
	// collecting data. Else, data collection stops.
	logic scanningActive;
	// ctr keeps count; each increment to ctr means a new byte is to
	// be collected.
	integer ctr;
	
	// 
	logic enableSecond;
	
	// 
	timerEnabled #(.DELAY(8)) tmrEnblTest (.clk, .reset, .beginTimer(startScanning),
	                                       .enable(enableSecond));
	
	// Initial Logic
	// 
	initial begin
		ctr  = -1;
		data = {8{1'b0}};
	end
	
	
	
	// Combinational Logic
	// Display data being collected
	always_comb begin
//		displayData = data;
		displayData = dataBuffer[ctr];
	end
	
	// Sequential Logic
	// If reset, reset local variables to initial state
	// Else if module inactive (ctr == -1) and startScanning goes high
	// Else if ctr is >= 0, continue counting and adding data
	always_ff @(posedge clk) begin
		if (reset) begin
			ctr <= -1;
			data <= {8{1'b0}};
		end else if ((ctr == -1) && startScanning) begin
			ctr <= ctr + 1;
		end else if (ctr >= 0 && enableSecond) begin
			ctr <= ctr + 1;
			dataBuffer[ctr] <= data;
			data <= data + 4'b0001;
		end
	end
	
endmodule

// Tester Module
module dataCollector_testbench();
	logic clk, reset; 
	logic startScanning;
	
	logic [7:0] displayData; // Display data being collected
	
	dataCollector dut (clk, reset, startScanning, displayData);
	
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
	startScanning <= 1;    @(posedge clk);
	startScanning <= 0;    @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  repeat (100) @(posedge clk);
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
