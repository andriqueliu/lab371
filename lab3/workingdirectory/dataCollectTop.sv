// !!!
// This module's processes can probably be written as a state machine.
// States determine variables such as out en, etc., whereas sequential logic
// can deal with latches such as address <= address + 1, etc.





/*
memoryTester is used to test the SRAM module; memoryTester first writes data into
the memory, and then reads them out, displaying them on the LEDs.




*/
module dataCollectTop (clk, reset, data, startWrite, startRead, clkLight, transferBit, clkOut, lights);
   input  logic  clk, reset;            // Clock, Reset signals
	inout  [7:0] data;          // Bidirectional 32-bit I/O port
	// 11-bit address input- see Note.
	// Note: From an external view, system interprets memory as having 32-bits/word per
	// location. This way, the memory is functionally word-addressable, with
	// 1024 functional 32-bit memory blocks.
	// Note: Within the memory, each location has 16-bits, for a total of 2048 16-bit
	// memory blocks.
	
	// Output enable: 1 to write to data, 0 to read from data
	
	// Active:
	
   // Read/Write: 1 to read, 0 to write to memory
	// Assume write takes place on posedge of RW (if RW is strobed for one cycle)
	// Note: If write is held low for more than one cycle, data is simply written until
	// one cycle after RW goes high.
	// Board peripherals
	input  logic startWrite, startRead;
	output logic clkLight;
	
	
	output logic transferBit;
	output logic clkOut;
	
	output logic [7:0] lights;
	
	assign lights = data;
	
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
	
//	// 
//	logic  [7:0] localData;
	
	
	// 
	integer i;
	
	// Delay iterator; 
	integer delayItr;
	
	
	
	
	// 
	dataCollect collector (.clk, .reset, .data, .address, .out_en, .active, .RW);
	
	// Initialize variables
	initial begin
		address = 0;;
		MDR = {7{1'b0}};
		writeReady = 1;
		readReady  = 1;
		
		
		i = 0;
		
		delayItr = 0;
	end
	
	// Combinational Logic
	// Output enable behavior:
	// If 1, IO port gets high Z (Write)
	// If 0, IO port gets data_out (Read) ??? Not sure if these are inverted, check later
	assign data[7:0] = !(!out_en && active && RW) ? MDR : 7'bZ; // !!! Negation
	
//	// 
//	assign clkOut = startRead ? clk : 1'bX;
//	// 
//	assign transferBit = startRead ? data[i] : 1'bX;
	
	// ??? What if it shouldn't be high X, what if it should be known? Like 0?
	// 
//	assign clkOut = startRead ? clk : 1'b0;
//	// 
//	assign transferBit = startRead ? data[i] : 1'b0;
	
	always_comb begin
		if (startRead) begin
			clkOut = clk;
			transferBit = data[i];
		end else begin
			clkOut = 1'b0;
			transferBit = 1'b0;
		end
	end
	
	
	
	// Sequential Logic
	// Reset: reset variables to initial variables
	// Else, if receive startWrite command and write is ready, begin
	// scanning/writing into memory.
	// Else, if receive startRead command and read is ready, begin
	// sending out serial data (transferring scanned data)
	always_ff @(posedge clk) begin
		if (reset) begin
			address <= 0;
			MDR <= 0;
			writeReady <= 1;
			readReady  <= 1;
			RW <= 0;
			out_en <= 1;
			active <= 1;
			
			i = 0;
		end else if (startWrite && writeReady) begin
//			if (address < 749) begin
			if (address < 14) begin
				if (delayItr < 14) begin
					delayItr <= delayItr + 1;
				end else if (delayItr == 14) begin
					delayItr <= delayItr + 1;
					MDR <= MDR + 1;
					address <= address + 1;
				end else if (delayItr == 15) begin
					delayItr <= 0;
				end
			end else begin
				writeReady <= 0;
				RW <= 1;
				out_en <= 0;
//				address <= 749;
				address <= 14;
			end
		end else if (startRead && readReady) begin
			if (address > -1) begin
				if (i < 6) begin
					i <= i + 1;
				end else if (i == 6) begin
					i <= i + 1;
					address <= address - 1;
				end else if (i == 7) begin
					i <= 0;
				end
			end else begin
				readReady <= 0;
				address <= -1;
			end
		end
	end
	
endmodule

// Tester Module
module dataCollectTop_testbench();
	logic  clk, reset;            // Clock, Reset signals
	wire [7:0] data;              // Bidirectional 32-bit I/O port
	logic startWrite, startRead;
	logic clkLight;
	logic transferBit;
	logic clkOut;
	logic [7:0] lights;
	
	dataCollectTop dut (clk, reset, data, startWrite, startRead, clkLight, transferBit, clkOut, lights);
	
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
						repeat (300) @(posedge clk);
	startRead <= 1;
						repeat (300) @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
