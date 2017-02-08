/*
memoryTester is used to test the SRAM module; memoryTester first writes data into
the memory, and then reads them out, displaying them on the LEDs.
*/
//module memoryTester (clk, reset, data, address, out_en, chip_s, RW, SW, KEY, LEDR);
//module memoryTester (clk, reset, data, SW, KEY, LEDR);
module dataCollectTop (clk, reset, data, startWrite, startRead, clkLight);
   input  logic  clk, reset;            // Clock, Reset signals
	inout  [7:0] data;          // Bidirectional 32-bit I/O port
	// 11-bit address input- see Note.
	// Note: From an external view, system interprets memory as having 32-bits/word per
	// location. This way, the memory is functionally word-addressable, with
	// 1024 functional 32-bit memory blocks.
	// Note: Within the memory, each location has 16-bits, for a total of 2048 16-bit
	// memory blocks.
//	input  logic [9:0] address;
	// Output enable: 1 to write to data, 0 to read from data
//   input  logic out_en;
	// Chip select: 1 to disable R/W, 0 to enable R/W
//	input  logic chip_s;
   // Read/Write: 1 to read, 0 to write to memory
	// Assume write takes place on posedge of RW (if RW is strobed for one cycle)
	// Note: If write is held low for more than one cycle, data is simply written until
	// one cycle after RW goes high.
	// Board peripherals
	input  logic startWrite, startRead;
	output logic clkLight;
	
	// Assign signals
	assign clkLight = clk;
	
	// Status signals: Read and Write 
	logic  writeReady, readReady;
	
	// Memory Address Registers: Adjacent addresses
	integer address;
	// Memory Data Registers: Combined
	logic  [7:0] MDR;
	// Output enable, chip select, RW
	logic  out_en, active, RW;
	
	dataCollect collector (.clk, .reset, .data, .address, .out_en, .active, .RW);
	
	// Initialize variables
	initial begin
		address = 0;;
		MDR = {7{1'b0}};
		writeReady = 1;
		readReady  = 1;
	end
	
	// Combinational Logic
	// Output enable behavior:
	// If 1, IO port gets high Z (Write)
	// If 0, IO port gets data_out (Read)
//	assign data[31:0] = !(!out_en && active && RW) ? MDR : 32'bZ; // !!! Negation
	assign data[7:0] = !(!out_en) ? MDR : 7'bZ; // !!! Negation
	
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			address <= 0;
			MDR <= 0;
			writeReady <= 1;
			readReady  <= 1;
			RW <= 0;
			out_en <= 1;
			active <= 1;
		end else if (startWrite && writeReady) begin
//			if (MAR < 127) begin // Currently writing
//				MAR <= MAR + 1;
//				MDR <= MDR - 1;
			if (address < 9) begin
				address <= address + 1;
				MDR <= MDR + 1;
			end else begin       // Writing complete
				writeReady <= 0;  // Clear writeReady
				
				RW <= 1;
				out_en <= 0;
//				chip_s <= 1; // ??? Do we wanna disable RW after write?
				// Prepare address for reading
				address <= 0;
			end
		end else if (startRead && readReady) begin
			if (address < 127) begin
				address <= address + 1;
			end else begin
				readReady <= 0;
				
				
			end
		end
	end
	
endmodule

// Tester module
module dataCollectTop_testbench();
	logic  clk, reset;            // Clock, Reset signals
	wire [7:0] data;          // Bidirectional 32-bit I/O port
	logic startWrite, startRead;
	logic clkLight;
	
	dataCollectTop dut (clk, reset, data, startWrite, startRead, clkLight);
	
	// Note: when ACCESSING memory, output enable logic is inverted
	// (depending which way you define it)
	// ...
	// Need to add chip select, all those other signals...
//	assign data = (out_en) ? data1 : 16'bz;
//	assign data[31:0] = (out_en) ? data1 : 32'bz;
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	// Test... set direction to pass data in
	// Then clear direction to read data
	initial begin
								  @(posedge clk);
	reset <= 1;            @(posedge clk);
	reset <= 0;            @(posedge clk);
	@(posedge clk);
	@(posedge clk);
	startWrite <= 1;
						repeat (20) @(posedge clk);
	startRead <= 1;
						repeat (20) @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
