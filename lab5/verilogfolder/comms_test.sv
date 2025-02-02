/*
EE 371 Final Project
2-Player Connect Four

Authors: Nikhil Grover, Andrique Liu, Emraj Sidhu

comms_test is used to test whether our serial IO modules are functional; this module
is intended to be tested using ModelSim, and is not designed to be ported to the board.


*/
module comms_test (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	input  logic 		  CLOCK_50; // 50MHz clock.
	output logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic  [9:0] LEDR;
	input  logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
	input  logic  [9:0] SW;
	inout  [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
	
	logic  [35:0] out_en, GPIO_0_in;
	
	integer i;
	always_comb begin
		// Set out_en so that something can be read from (output)
		// Clear out_en so that something can be written into (input)
		for (i = 0; i < 36; i++) begin
			GPIO_0[i] = (out_en[i]) ? GPIO_0_in[i] : 1'bZ;
		end
	end

	// Configure outputs
	assign out_en[0] = 1'b1; // Reset out
	assign out_en[1] = 1'b1; // Clk out
	assign out_en[2] = 1'b1; // Serial out
	// Configure inputs
	assign out_en[3] = 1'b0; // Ready in
	
	// Configure inputs
	assign out_en[4] = 1'b0; // Reset in
	assign out_en[5] = 1'b0; // Clk in
	assign out_en[6] = 1'b0; // Serial in
	// Configure outputs
	assign out_en[7] = 1'b1; // Ready out
	
	// 
	logic  reset;
	assign reset = (~KEY[3] || GPIO_0[4]);
	assign GPIO_0_in[0] = ~KEY[3];
	
	// 
	logic  enter, enter_out;
	assign enter = ~KEY[2];
	uinput user_input (.clk(CLOCK_50), .reset, .in(enter), .out(enter_out));
	
	// 
	logic [6:0] local_reg;
	
	assign LEDR[6:0] = local_reg;
	
	always_comb begin
//		if (SW[9]) begin
////			local_reg = 3'b010;
//			local_reg = 
//		end else if (SW[8]) begin
////			local_reg = 3'b110;
//		end else if (SW[7]) begin
////			local_reg = 3'b111;
//		end else begin
////			local_reg = 3'b000;
//		end
		
		
	end
	
	// 
	serial_out ser_out (.clk(CLOCK_50), .reset, .ready_in( ), .column(SW[6:0]),
	                    .enter(enter_out), .clk_out(GPIO_0_in[1]), .bit_out(GPIO_0_in[2]));
	
	// 
	serial_in ser_in (.clk(CLOCK_50), .reset, .clk_in(GPIO_0[5]), .bit_in(GPIO_0[6]),
	                  .column_select(local_reg));
		
	// Turn off unused hex displays
	assign HEX0[6:0] = ~(7'b0000000);
	assign HEX1[6:0] = ~(7'b0000000);
	assign HEX2[6:0] = ~(7'b0000000);
	assign HEX3[6:0] = ~(7'b0000000);
	assign HEX4[6:0] = ~(7'b0000000);
	assign HEX5[6:0] = ~(7'b0000000);
	
endmodule

//// Tester Module
//module main_testbench();
//	logic 		 CLOCK_50; // 50MHz clock.
//	logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
//	logic  [9:0] LEDR;
//	logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
//	logic  [9:0] SW;
////	output logic [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
//	wire  [35:0] GPIO_0;
//	
//	main dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
//	
//	// Set up the clock.
////	parameter CLOCK_PERIOD=100;
////	initial begin
////		clk <= 0;
////		forever #(CLOCK_PERIOD/2) clk <= ~clk;
////	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	// Test... set direction to pass data in
//	// Then clear direction to read data
//	initial begin
//								  @(posedge clk);
//	KEY[3] <= 1;            @(posedge clk);
//	KEY[0] <= 0;            @(posedge clk);
//	@(posedge clk);
//	@(posedge clk);
//	SW[9] <= 1;
//						repeat (250) @(posedge clk);
//	SW[8] <= 1;
//						repeat (80) @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	$stop; // End the simulation.
//	end
//endmodule
