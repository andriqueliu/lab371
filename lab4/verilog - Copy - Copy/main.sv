/*




*/
module main (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	input  logic 		  CLOCK_50; // 50MHz clock.
	output logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic  [9:0] LEDR;
//	output logic  [9:1] LEDR;
	input  logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
	input  logic  [9:0] SW;
	inout  [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
	
	// 
	logic [31:0] clk;
	parameter whichClock = 15;   // Roughly 768 Hz
//	parameter whichClock = 20; //  Hz
	clock_divider cdiv (CLOCK_50, clk);
	
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
	// GPIOs 35, 34, 32, 25, 24 are outputs
	assign out_en[35] = 1'b1;
	assign out_en[34] = 1'b1;
	assign out_en[32] = 1'b1;
	assign out_en[25] = 1'b1;
	assign out_en[24] = 1'b1;
	
	// Configure inputs
	// GPIOs 33, 31, 29, 28, 26 are inputs
	assign out_en[33] = 1'b0;
	assign out_en[31] = 1'b0;
	assign out_en[29] = 1'b0;
	assign out_en[28] = 1'b0;
	assign out_en[26] = 1'b0;
	
	logic reset;
	assign reset = ~KEY[3];
	
	// 
//	nios_system nios (
//		.clk_clk(CLOCK_50),          //      clk.clk
//		.reset_reset_n(reset),    //    reset.reset_n
//		.switches_export(SW),  // switches.export
//		.leds_export(LEDR),      //     leds.export
//		.keys_export(KEY),      //     keys.export
//		.hex0_export( ),      //     hex0.export
//		.hex1_export( ),      //     hex1.export
//		.hex2_export( ),      //     hex2.export
//		.hex3_export( ),      //     hex3.export
//		.hex4_export( ),      //     hex4.export
//		.hex5_export( ),      //     hex5.export
////		.gpio_0_out_export({ GPIO_0_in[35], GPIO_0_in[34], GPIO_0_in[32], GPIO_0_in[25], GPIO_0_in[24] }),
////		.gpio_0_in_export({ GPIO_0[33], GPIO_0[31], GPIO_0[29], GPIO_0[28], GPIO_0[26] })
//		.gpio_0_out_export({ GPIO_0_in[35], GPIO_0_in[34], GPIO_0_in[32], GPIO_0_in[25], GPIO_0_in[24] }),
//		.gpio_0_in_export({ GPIO_0[33], GPIO_0[31], GPIO_0[29], GPIO_0[28], GPIO_0[26] })
//	);

	nios_system nios (
		.clk_clk(CLOCK_50),           //        clk.clk
//		.reset_reset_n(KEY[3]),     //      reset.reset_n
		.reset_reset_n(KEY[2]),     //      reset.reset_n
		.switches_export({ SW[9], SW[8] }),   //   switches.export
		.gpio_0_out_export({ GPIO_0_in[25], GPIO_0_in[24] }), // gpio_0_out.export
		.gpio_0_in_export(GPIO_0_in[26])   //  gpio_0_in.export
	);
	
	
	
	// 
//	logic  startWrite, readySwitch;
//	assign reset = ~KEY[3];


	// done by Processor
//	assign startWrite = SW[9];
//	assign readySwitch  = SW[8];
	
//	logic  SWScan, SWReady;
//	assign GPIO_0_in[24] = SW[9];
//	assign GPIO_0_in[25] = SW[8];
	
	
	
	// Assign reference clock for debugging and probing
	assign LEDR[9] = clk[whichClock];
	
	logic  testSerial, testClkOut;
	
	// 
	logic  [3:0] hexLSBInput, hexMSBInput;
	hexDriver hexDriveLSB (.value(hexLSBInput), .leds(HEX0));
	hexDriver hexDriveMSB (.value(hexMSBInput), .leds(HEX1));
	
//	// !!! this module also has to have an 
//	dataCollectTop collectTop (.clk(clk[whichClock]), .reset, .data( ),
//	                           .startWrite, .startRead(GPIO_0[33]), .clkLight( ),
//										.transferBit(GPIO_0_in[35]), .clkOut(GPIO_0_in[34]),
////										.lights(LEDR[7:0]),
//                              .lights({ hexMSBInput, hexLSBInput }),
//										.stateHEX(HEX4),
//										.pctgHEX(HEX5));
//	
//	// 
//	transfer transferTop(.clk(GPIO_0[28]), .reset, .data_scan9]),
//	                     .readyIn(readySwitch), .readyOut(GPIO_0_in[27]));
	
	logic  startWrite;
	assign startWrite = GPIO_0[31] || SW[0];
	
	
	// !!! this module also has to have an 
	dataCollectTop collectTop (.clk(clk[whichClock]), .reset, .data( ),
	                           .startWrite, .startRead(GPIO_0[33]), .clkLight( ),
										.transferBit(GPIO_0_in[35]), .clkOut(GPIO_0_in[34]),
                              .lights({ hexMSBInput, hexLSBInput }),
										.stateHEX(HEX4),
										.pctgHEX(HEX5));
	
	// 
	transfer transferTop(.clk(GPIO_0[28]), .reset, .data_scanner(GPIO_0[29]),
	                     .readyIn( ), .readyOut( ));
	
	// Turn off unused hex displays
	assign HEX2[6:0] = ~(7'b0000000);
	assign HEX3[6:0] = ~(7'b0000000);
	
	
	
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
