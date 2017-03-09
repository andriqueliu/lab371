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
	
	logic  reset, enter_in, enter;
	assign reset = ~KEY[3];
	assign enter_in = ~KEY[2];
	
	// ---------------------------------------------------- //
	
	logic  test_enter_in, test_enter;
	assign test_enter_in = ~KEY[1];
	uinput user_input (.clk(clk[whichClock]), .reset, .in(test_enter_in), .out(test_enter));
	
	// ---------------------------------------------------- //
	
	logic  [6:0] drop_red, drop_green;
	
	uinput test_user_input (.clk(clk[whichClock]), .reset, .in(enter_in), .out(enter));
	
//	change_Player change (.clk, .reset, .enter, .ready_in, .leds, .P1, .P2, .ready_out);
	
	native_board_input nat_b_in (.clk(clk[whichClock]), .reset, .column(SW[6:0]),
	                             .enter, .column_select(drop_red));
	
	native_board_input test_nat_b_in (.clk(clk[whichClock]), .reset, .column(SW[6:0]),
	                             .enter(test_enter), .column_select(drop_green));
	
	// You're getting ROWS ([5:0])
//	logic  [5:0][6:0] red_on, green_on;
	logic  [5:0][7:0] red_on, green_on;
	
	// Enter below???
	grid led_array (.clk(clk[whichClock]), .reset, .enter( ), .drop_red, .drop_green,
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
