/*
EE 371 Winter 2017
Lab 3 Project
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu



*/
//module dataCollectTop (clk, reset, startScanning, displayData);
module dataCollectTop (clk, reset, data, startScanning);
	input  logic clk, reset;
	inout  [7:0] data;
	input  logic startScanning;
	

	// 8-bit data that represents scanned data to be inserted into
	// the data buffer
	logic  [7:0] scannedData;
	integer address;
	// scanningActive acts as a boolean; if true, scanner is active and is
	// collecting data. Else, data collection stops.
	
	// scanReady indicates the scanner is ready to scan data, thereby having data
	// written into its memory.
	logic  scanReady;
	
	logic  out_en, active, RW;
	
	
	dataCollect collector (.clk, .reset, .data, .address, .out_en, .active, .RW);
	
	
	// Initial Logic
	// 
	initial begin
		address = 0;
		scannedData = {8{1'b0}};
		scanReady = 1;
	end
	
	// Combinational Logic
	// Display data being collected
	
	assign data[7:0] = !(!out_en && active && RW) ? scannedData : 8'bZ;
	
	
	// Sequential Logic
	// If reset, reset local variables to initial state
	// Else if module inactive (ctr == -1) and startScanning goes high
	// Else if ctr is >= 0, continue counting and adding data
	always_ff @(posedge clk) begin
		if (reset) begin
			address <= 0;
			data <= {8{1'b0}};
			RW <= 0;
			out_en <= 1;
			active <= 1;
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
