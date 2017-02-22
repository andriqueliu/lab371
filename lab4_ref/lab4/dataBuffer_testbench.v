// EE371 Lab4 Autumn 2016
// Authors: Dawn Liang, Jun Park, William Li
// Date: 
//
// testbench for dataBuffer module; tests all possible state inputs
module dataBuffer_testbench();
	reg [2:0] state;
	reg clk, reset;
	wire [3:0] percentage;
	wire [7:0] data_in, data_out;
	assign data_in = percentage;

	dataBuffer dut (.data_out(data_out), .data_in(data_in), .percentage(percentage), .state(state), .clk(clk), .reset(reset));

	// set up clock
	parameter CLOCK_PERIOD = 10;
	initial clk = 0;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end

	initial begin
		reset <= 1;						@(posedge clk);
										@(posedge clk);
		reset <= 0;	state <= 3'b000;	@(posedge clk); // lowPower
										@(posedge clk);
										@(posedge clk);
					state <= 3'b001;	@(posedge clk); // standby
										@(posedge clk);
										@(posedge clk);
					state <= 3'b010;	@(posedge clk); // scanning
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
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
					state <= 3'b011;	@(posedge clk); // idle
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
					state <= 3'b100;	@(posedge clk); // xfer
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
					state <= 3'b101;	@(posedge clk); // flush
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		$finish;
	end

	// gtkwave filedump
	initial begin
		$dumpfile("dataBuffer.vcd");
		$dumpvars;
	end
endmodule