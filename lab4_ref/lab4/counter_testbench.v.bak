// EE371 Lab3 Autumn 2016
// Authors: Dawn Liang, William Li, Jun park
// Date: 13 Nov 2016
//
// testbench for the counter module; tests all counting conditions
`include "counter.v"
module counter_testbench();
	reg up, down, clk, reset;
	wire [3:0] percentage;
	wire final_clock;
	wire [7:0] data_out, data_in;
	
	assign data_in = percentage;

	counter dut (.data_out(data_out), .data_in(data_in), .percentage(percentage), .up(up), .down(down), .clk(clk), .reset(reset));

	// set up clock
	parameter CLOCK_PERIOD = 10;
	initial clk = 0;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end

	// begin simulation
	initial begin
		reset <= 1;							@(posedge clk);
											@(posedge clk);
		reset <= 0; up <= 0; down <= 0;		@(posedge clk);
											@(posedge clk);
											@(posedge clk);
					up <= 1;				@(posedge clk); // 0
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk); // 5
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk); // 10
											@(posedge clk);
											@(posedge clk);
							down <= 1;		@(posedge clk);
					up <= 0;				@(posedge clk); // 10
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk); // 5
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk); // 0
											@(posedge clk);
							down <= 0;		@(posedge clk);
											@(posedge clk);
		$finish;
	end

	// gtkwave filedump
	initial begin
		$dumpfile("counter.vcd");
		$dumpvars;
	end
endmodule