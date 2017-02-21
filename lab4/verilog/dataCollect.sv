/*
memory functions as a static RAM, with 2K (2048) x 16-bit memory locations.
From an external view, memory functionally has 1K (1024) x 32-bit memory locations.
This means that addresses entered into this module are assumed to range from 0 to 1023.

memory supports RW operations, executing these operations using a 32-bit I/O port.

To operate memory, clear chip_select to select the device and enable R/W operations. 
Reading: Clear output enable, enter address into MAR, set RW
Writing: Set output enable, enter address and write data in MDR, and clear RW

Note: Signals in memory propagate after delay (example: when reading, it will take
a propagation delay after entering an address to display memory's data).

Note: Reset operation is NOT supported in memory module, as it is too costly
to wipe the memory module.
*/
module dataCollect (clk, reset, data, address, out_en, active, RW);
   input  logic clk, reset;     // Clock, Reset signals
	inout  [7:0] data;           // Bidirectional 32-bit I/O port
	// 11-bit address input- see Note.
	// Note: From an external view, system interprets memory as having 32-bits/word per
	// location. This way, the memory is functionally word-addressable, with
	// 1024 functional 32-bit memory blocks.
	// Note: Within the memory, each location has 16-bits, for a total of 2048 16-bit
	// memory blocks.
	input  integer address;
	// Output enable: 1 to write to data, 0 to read from data
   input  logic out_en;
	// Chip select: 1 to disable R/W, 0 to enable R/W
	input  logic active;
   // Read/Write: 1 to read, 0 to write to memory
	// Assume write takes place on posedge of RW (if RW is strobed for one cycle)
	// Note: If write is held low for more than one cycle, data is simply written until
	// one cycle after RW goes high.
	input  logic RW;
	
	// Memory Data Registers: higher bits and lower bits
	logic  [7:0] MDR;
	
	// 10 entry, 8-bit wide data buffer
   logic  [7:0] stored_memory [10];
	
	// Combinational Logic
	// Output enable behavior:
	// If 1, IO port gets high Z (Write)
	// If 0, IO port gets data_out (Read)
	assign data = (!out_en && active && RW) ? MDR : 8'bZ;
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (RW && !out_en && active) begin            // Read from memory
			MDR <= stored_memory[address];
		end else if (!RW && out_en && active) begin   // Write to memory
			stored_memory[address] <= data;
		end else begin                                // Default: Unknown values
			MDR <= 8'bX;
		end
	end
	
endmodule

// Tester Module
module dataCollect_testbench();
	logic clk, reset;     // Clock, Reset signals
	wire [7:0] data;          // Bidirectional 32-bit I/O port
	// 11-bit address input- see Note.
	// Note: From an external view, system interprets memory as having 32-bits/word per
	// location. This way, the memory is functionally word-addressable, with
	// 1024 functional 32-bit memory blocks.
	// Note: Within the memory, each location has 16-bits, for a total of 2048 16-bit
	// memory blocks.
	integer address;
	// Output enable: 1 to write to data, 0 to read from data
   logic out_en;
	// Chip select: 1 to disable R/W, 0 to enable R/W
	logic active;
   // Read/Write: 1 to read, 0 to write to memory
	// Assume write takes place on posedge of RW (if RW is strobed for one cycle)
	// Note: If write is held low for more than one cycle, data is simply written until
	// one cycle after RW goes high.
	logic RW;
	
	logic [7:0] data1;
	
	dataCollect dut (clk, reset, data, address, out_en, active, RW);
	
	// Note: when ACCESSING memory, output enable logic is inverted
	// (depending which way you define it)
	// ...
	// Need to add chip select, all those other signals...
//	assign data = (out_en) ? data1 : 16'bz;
	assign data[7:0] = (out_en) ? data1 : 8'bZ;
	
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
	active <= 1; 	        @(posedge clk);
								  @(posedge clk);
	RW <= 1;               @(posedge clk);
								  @(posedge clk);
	out_en <= 1; address <= 0; data1 <= 3; @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	RW <= 0;               @(posedge clk);
	RW <= 1;               @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	address <= 2; data1 <= 5; @(posedge clk);
								  @(posedge clk);
	RW <= 0;               @(posedge clk);
	RW <= 1;               @(posedge clk);
	address <= 5; data1 <= 2; @(posedge clk);
								  @(posedge clk);
	RW <= 0;               @(posedge clk);
	RW <= 1;               @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	out_en <= 0; address <= 5; @(posedge clk);
								  @(posedge clk);
	address <= 2;     @(posedge clk);
	address <= 0;  @(posedge clk);



////	out_en <= 1; address <= 11'b00; data1 <= {16{1'b1}}; data2 <= {16{1'b1}}; @(posedge clk);
//	out_en <= 1; address <= 11'b00; data1 <= {16{1'b1}}; data2 <= {16{1'b0}}; @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	RW <= 0;               @(posedge clk);
//	RW <= 1;               @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	address <= 11'b01; data1 <= {16{1'b0}}; data2 <= {16{1'b0}}; @(posedge clk);
//								  @(posedge clk);
//	RW <= 0;               @(posedge clk);
//	RW <= 1;               @(posedge clk);
//	address <= 11'b01000; data1 <= 16'b0000111100001111; data2 <= 16'b0000111100001111; @(posedge clk);
//								  @(posedge clk);
//	RW <= 0;               @(posedge clk);
//	RW <= 1;               @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	out_en <= 0; address <= 11'b010; @(posedge clk);
//								  @(posedge clk);
//	address <= 11'b01;     @(posedge clk);
//	address <= 11'b01000;  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
//	out_en <= 1; address <= 4'b0111; data1 <= 4'b0000; @(posedge clk);
//	RW <= 0;               @(posedge clk);
//	RW <= 1;               @(posedge clk);
//	out_en <= 0;           @(posedge clk);
//	address <= 4'b0110;    @(posedge clk);
//								  @(posedge clk);
//	address <= 4'b0000;    @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
