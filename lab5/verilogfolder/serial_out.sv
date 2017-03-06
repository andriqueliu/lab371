/*




*/
module serial_out (clk, reset, ready_in, column, enter, clk_out, bit_out);
	input  logic clk, reset;
	input  logic ready_in;
	
	input  logic [7:0] column;
	input  logic enter;
	
	output logic clk_out, bit_out;
	
	logic [2:0] serial_register;
	
	encoder enc (.clk, .reset, .column, .select(serial_register));
	
	// serial_active determines whether the module is currently sending serial data.
	// i iterates through the serial_register, selecting which bit to output.
	logic serial_active;
	integer i;
	
	// Initialize registers
	initial begin
		serial_active = 0;
		i = 0;
	end
	
	// Combinational Logic
	// If serial output is active (serial_active), then match clk_out to clk
	// and send out serial data. Otherwise, keep output ports low.
	always_comb begin
		if (serial_active) begin
			clk_out = clk;
			bit_out = serial_register[i];
		end else begin
			clk_out = 0;
			bit_out = 0;
		end
	end
	
	// -------------------------------------------------------- //
	// Sequential Logic Block
	
	// This block sends serial data and iterates through the serial_register.
	// Also, this block controls serial_active and iterator through the
	// serial_register.
	always_ff @(posedge clk) begin
		if (reset) begin
			 i <= 0;
			 serial_active <= 0;
		end else if (enter && !serial_active) begin
			serial_active <= 1;
		end else if (i == 0 && serial_active) begin
			i <= 1;
		end else if (i == 1 && serial_active) begin
			i <= 2;
		end
	end
	
	// Watch for the negedge of the clock; otherwise, an extra posedge
	// will be sent through clk_out.
	always_ff @(negedge clk) begin
		if (i == 2 && serial_active) begin
			serial_active <= 0;
			i <= 0;
		end
	end
	
	// End Sequential Logic Block
	// -------------------------------------------------------- //
	
	
endmodule

// Tester Module
module serial_out_testbench();
	logic clk, reset;
	logic ready_in;
	
	logic [7:0] column;
	logic enter;
	
	logic clk_out, bit_out;
	
	serial_out dut (clk, reset, ready_in, column, enter, clk_out, bit_out);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	reset <= 1;							  @(posedge clk);
	reset <= 0;							  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	column <= 8'b00000010;							  @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk);
								  @(posedge clk);
	repeat (10) @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk); // Enter right after
								  @(posedge clk);
								  @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk);
								  @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk); // Enter one cycle later
								  @(posedge clk);
	repeat (5) @(posedge clk);
								  @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk); // Enter two cycles later
	repeat (6) @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	column <= 8'b10000000;							  @(posedge clk);
	enter <= 1;							  @(posedge clk);
	enter <= 0;							  @(posedge clk);
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
