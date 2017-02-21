module towtest (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  logic 		 CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input  logic [3:0] KEY; // True when not pressed, False when pressed
	input  logic [9:0] SW;
	
//	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 25; // default is 25
	clock_divider cdiv (CLOCK_50, clk);
	
	logic reset;
	assign reset = SW[9];
	logic L, R;
	
//	uinput ui2 (.clk(clk[whichClock]), .reset, .in(KEY[3]), .out(L)); // out port is not responding, maybe not L,R data type
//	uinput ui1 (.clk(clk[whichClock]), .reset, .in(KEY[0]), .out(R));
	
	uinput ui2 (.clk(CLOCK_50), .reset, .in(KEY[3]), .out(L)); // out port is not responding, maybe not L,R data type
	uinput ui1 (.clk(CLOCK_50), .reset, .in(KEY[0]), .out(R));
	
	normalLight l9 (.clk(CLOCK_50), .reset, .L, .R, .NL(0), .NR(LEDR[8]), .lightOn(LEDR[9]));
	normalLight l8 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
	normalLight l7 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
	normalLight l6 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
	centerLight l5 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5])); // seems that it's not receiving the L signal from this module 
	normalLight l4 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
	normalLight l3 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
	normalLight l2 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
	normalLight l1 (.clk(CLOCK_50), .reset, .L, .R, .NL(LEDR[2]), .NR(0), .lightOn(LEDR[1]));

//	normalLight l9 (.clk(clk[whichClock]), .reset, .L, .R, .NL(0), .NR(LEDR[8]), .lightOn(LEDR[9]));
//	normalLight l8 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
//	normalLight l7 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
//	normalLight l6 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
//	centerLight l5 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5])); // seems that it's not receiving the L signal from this module 
//	normalLight l4 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
//	normalLight l3 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
//	normalLight l2 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
//	normalLight l1 (.clk(clk[whichClock]), .reset, .L, .R, .NL(LEDR[2]), .NR(0), .lightOn(LEDR[1]));
	
endmodule

// To simulate, you not only have to provide the inputs, but you also
// have to specify the clock, hence the testbench
module towtest_testbench();
	logic 		CLOCK_50; // 50MHz clock.
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed
	logic [9:0] SW;
	
	towtest dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge CLOCK_50);
	SW[9] <= 1;				  @(posedge CLOCK_50);
	            			  @(posedge CLOCK_50);
	SW[9] <= 0;				  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
	KEY[0] <= 0; KEY[3] <= 0;			  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
	KEY[3] <= 1;			  @(posedge CLOCK_50);
//	KEY[3] <= 0;			  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
	KEY[3] <= 0;			  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
	KEY[3] <= 1;	@(posedge CLOCK_50);
	KEY[3] <= 0;	@(posedge CLOCK_50);
	KEY[3] <= 1;	@(posedge CLOCK_50);
	KEY[3] <= 0;	@(posedge CLOCK_50);
						@(posedge CLOCK_50);
						@(posedge CLOCK_50);
						@(posedge CLOCK_50);
						@(posedge CLOCK_50);
	$stop; // End the simulation.
	end
endmodule