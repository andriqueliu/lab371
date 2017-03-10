/*






GPIO_0 Port Orientation:
	In data 0 them, 7 us
	In clk
	In ready
	In reset
	Out data
	Out clk
	Out ready
	Out reset 7 them, 0 us
*/
module Lab_5 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	input  logic 		  CLOCK_50; // 50MHz clock.
	output logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic  [9:0] LEDR;
	input  logic  [3:0] KEY;    // True when not pressed, False when pressed (For the physical board)
	input  logic  [9:0] SW;
	
	inout  [35:0] GPIO_0; // [0] is the leftmost, [35] rightmost
	
	// Clock Divider
	logic [31:0] clk;
	parameter whichClock = 15; // Roughly 768 Hz
	clock_divider cdiv (CLOCK_50, clk);
	
	// Configure GPIO_0 pins
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
	
	// Configure communication GPIOs
	assign out_en[7] = 0; // Data in
	assign out_en[6] = 0; // Clk in
	assign out_en[5] = 0; // Ready in
	assign out_en[4] = 0; // Reset in
	assign out_en[3] = 1; // Data out
	assign out_en[2] = 1; // Clk out
	assign out_en[1] = 1; // Ready out
	assign out_en[0] = 1; // Reset out
	
	// Configure reset and enter signals
	logic  reset_in, reset, enter, enter_check;
	// Reset by either native or other board's reset
	assign reset = (reset_in || GPIO_0[4]);
	// Reset output
	assign GPIO_0_in[0] = reset_in;
	// Debounce reset key
	uinput reset_input (.clk(CLOCK_50), .reset(reset_in), .in(~KEY[3]), .out(reset_in));
	// Debounce enter key: the output of this uinput module will be checked by
	// the legal checker.
	uinput u_in (.clk(CLOCK_50), .reset, .in(~KEY[2]), .out(enter_check));
	
	// 
	legality_checker legal (.clk(CLOCK_50), .reset, .enter_input(enter_check),
	                        .column_select(SW[6:0]), .enter_output(enter));
	
	// Three_in indicates that the serial input module has received a full 3-bit sequence
	// Three_out indicates that the serial output module has sent a full 3-bit sequence
	logic  three_in, three_out;
	
	// Serial output module: Player makes moves on their turn; these commands are also
	// sent to the serial output module to be sent to the other player.
	serial_out ser_out (.clk(CLOCK_50), .reset, .ready_in( ), .column(SW[6:0]),
	                    .enter, .clk_out(GPIO_0_in[2]), .bit_out(GPIO_0_in[3]),
							  .output_complete(three_out));
	
	// 
	logic  [6:0] serial_red, serial_green;
	
	// 
	serial_in ser_in (.clk(CLOCK_50), .reset, .clk_in(GPIO_0[6]), .bit_in(GPIO_0[7]),
	                  .column_select(serial_green), .constant_col_sel(LEDR[6:0]),
							.three_in);
	
	// 
	logic  [6:0] drop_red, drop_green;
	logic  [6:0] drop_RG;
	logic  P1, P2;
	assign LEDR[8] = P1;
	assign LEDR[7] = P2;
	
	// 
	logic  enter_red, enter_green;
	
	// 
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
	
	// 
	change_Player change (.clk(CLOCK_50), .reset, .enter, .ready_in(GPIO_0[5]),
	                      .three_in, .three_out, .P1, .P2, .ready_out(GPIO_0_in[1]));
	
	// 
	native_board_input nat_b_in (.clk(CLOCK_50), .reset, .column(SW[6:0]),
	                             .enter(enter_red), .column_select(drop_red));
	native_board_input nat_b_in1 (.clk(CLOCK_50), .reset, .column(SW[6:0]),
	                             .enter(enter_green), .column_select(drop_green));
	
	// Rows... 
	logic  [5:0][7:0] red_on, green_on;
	
	// 
	grid led_array (.clk(CLOCK_50), .reset, .enter( ), .drop_red, .drop_green(g),
	                .red_on,
						 .green_on);
	
	// 
	logic  [7:0] blank_row_1, blank_row_2;
	
	// 
	led_matrix_driver driver (.clk(clk[whichClock]),
                             .red_array({ blank_row_1,
									               blank_row_2,
									               red_on }),
	                          .green_array({ blank_row_1,
									                 blank_row_2,
														  green_on }), 
									  .red_driver(GPIO_0_in[27:20]), .green_driver(GPIO_0_in[35:28]),
									  .row_sink(GPIO_0_in[19:12]));
	
endmodule
