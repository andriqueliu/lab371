/*




*/
module Lab_5 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	input  logic 		  CLOCK_50; // 50MHz clock.
	output logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic  [9:0] LEDR;
	input  logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
	input  logic  [9:0] SW;
	
//	output logic [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
	
	inout  [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
	
	// 
	logic [31:0] clk;
	parameter whichClock = 15;   // Roughly 768 Hz
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

	// Configure LED grid outputs
	assign out_en[35:12] = {24{1'b1}};
	// Configure outputs
//	assign out_en[0] = 1'b1; // Reset out
//	assign out_en[1] = 1'b1; // Clk out
//	assign out_en[2] = 1'b1; // Serial out
//	// Configure inputs
//	assign out_en[3] = 1'b0; // Ready in
//	
//	// Configure inputs
//	assign out_en[4] = 1'b0; // Reset in
//	assign out_en[5] = 1'b0; // Clk in
//	assign out_en[6] = 1'b0; // Serial in
//	// Configure outputs
//	assign out_en[7] = 1'b1; // Ready out
	
	/*
	In data 0 them, 7 us
	In clk
	In ready
	In reset
	out data
	out clk
	out ready
	out reset 7 them, 0 us
	
	*/
	assign out_en[7] = 0; // Data in
	assign out_en[6] = 0; // Clk in
	assign out_en[5] = 0; // Ready in
	assign out_en[4] = 0; // Reset in
	assign out_en[3] = 1; // Data out
	assign out_en[2] = 1; // Clk out
	assign out_en[1] = 1; // Ready out
	assign out_en[0] = 1; // Reset out
	
	// !!!!!!!!!! FIX UP RESET IF YOU HAVE TIME // 
	
	logic  reset_in, reset, enter_in, enter;
//	assign reset = (~KEY[3] || GPIO_0[4]);
	assign reset = (reset_in || GPIO_0[4]);
	
//	assign GPIO_0_in[0] = ~KEY[3];
	assign GPIO_0_in[0] = reset_in;
	uinput reset_input (.clk(CLOCK_50), .reset(reset_in), .in(~KEY[3]), .out(reset_in));
	
//	assign enter_in = ~KEY[2];
	
	uinput u_in (.clk(CLOCK_50), .reset, .in(~KEY[2]), .out(enter));
	
	logic  three_in;
	logic  three_out;
	
	// !!! Clocks for serial comms are still 50 rn
	// 
	serial_out ser_out (.clk(CLOCK_50), .reset, .ready_in( ), .column(SW[6:0]),
	                    .enter, .clk_out(GPIO_0_in[2]), .bit_out(GPIO_0_in[3]),
							  .output_complete(three_out));
	
	logic  [6:0] serial_red, serial_green;
	
	// 
	serial_in ser_in (.clk(CLOCK_50), .reset, .clk_in(GPIO_0[6]), .bit_in(GPIO_0[7]),
	                  .column_select(serial_green), .constant_col_sel(LEDR[6:0]),
							.three_in);
//	serial_in ser_in1 (.clk(CLOCK_50), .reset, .clk_in(GPIO_0[6]), .bit_in(GPIO_0[7]),
//	                   .column_select(serial_green), .constant_col_sel( ),
//							 .);
	
	// ---------------------------------------------------- //
	
//	logic  test_enter_in, test_enter;
//	assign test_enter_in = ~KEY[1];
//	uinput user_input (.clk(clk[whichClock]), .reset, .in(test_enter_in), .out(test_enter));
	
	// ---------------------------------------------------- //
	
	logic  [6:0] drop_red, drop_green;
	logic  [6:0] drop_RG;
	logic  P1, P2;
	assign LEDR[8] = P1;
	assign LEDR[7] = P2;
	
	logic  enter_red, enter_green;
	
	logic  [6:0] r, g;
	
	// 
	always_comb begin
		if (P1 && !P2) begin
			enter_red = enter;
			enter_green = 0;
			
			r = drop_red;
			g = 7'b0000000;
		end else begin
			enter_red = 0;
			enter_green = 0;
			
			r = 7'b0000000;
			g = serial_green;
		end
	end
	
	change_Player change (.clk(CLOCK_50), .reset, .enter, .ready_in(GPIO_0[5]),
	                      .three_in, .three_out, .P1, .P2, .ready_out(GPIO_0_in[1]));
//	clk, reset, enter, ready_in, three_in, three_out, P1, P2, ready_out
	
	// This needs to accomodate the serial in
	native_board_input nat_b_in (.clk(CLOCK_50), .reset, .column(SW[6:0]),
	                             .enter(enter_red), .column_select(drop_red));
	native_board_input nat_b_in1 (.clk(CLOCK_50), .reset, .column(SW[6:0]),
	                             .enter(enter_green), .column_select(drop_green)); // ???
	
	// You're getting ROWS ([5:0])
	logic  [5:0][7:0] red_on, green_on;
	
	// Enter below???
	// 
//	grid led_array (.clk(clk[whichClock]), .reset, .enter( ), .drop_red(r), .drop_green(g),
//	                .red_on,
//						 .green_on);
	
	grid led_array (.clk(CLOCK_50), .reset, .enter( ), .drop_red, .drop_green(g),
	                .red_on,
						 .green_on);
	
	logic  [7:0] blank_row_1, blank_row_2;
	
//	logic  [7:0][7:0] tests;
//	assign tests[7] = 8'b10101010; // Highest
//	assign tests[6] = 8'b01010100;
//	assign tests[5] = 8'b10101010;
//	assign tests[4] = 8'b01010100;
//	assign tests[3] = 8'b00000000;
//	assign tests[2] = 8'b11111110;
//	assign tests[1] = 8'b11100010;
//	assign tests[0] = 8'b11101010; // Lowest
	
	led_matrix_driver driver (.clk(clk[whichClock]),
//	                          .red_array({ 8'b10101010, 8'b01010101, 8'b00000001,
//									               8'b11111110, 8'b11100010, 8'b00000001,
//														8'b00011100, 8'b01010111 }),

//						           .red_array(tests),

                             .red_array({ blank_row_1,
									               blank_row_2,
									               red_on }),
	                          .green_array({ blank_row_1,
									                 blank_row_2,
														  green_on }), 
									  .red_driver(GPIO_0_in[27:20]), .green_driver(GPIO_0_in[35:28]),
									  .row_sink(GPIO_0_in[19:12]));
	
	
	
	
	
endmodule

//// Tester Module
//module Lab_5_testbench();
//	logic 		  CLOCK_50; // 50MHz clock.
//	logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
//	logic  [9:0] LEDR;
//	logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
//	logic  [9:0] SW;
//	
//	wire [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
//	
//	Lab_5 dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
//	
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	initial begin
//								  @(posedge clk);
//	KEY[3] <= 1;           @(posedge clk);
//	KEY[3] <= 0;           @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	KEY[2] <= 1;           @(posedge clk);
//	KEY[2] <= 0;           @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//								  @(posedge clk);
//	$stop; // End the simulation.
//	end
//endmodule
