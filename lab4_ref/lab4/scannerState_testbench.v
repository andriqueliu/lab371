// EE371 Lab3 Autumn 2016
// Authors: Dawn Liang, William Li, Jun Park
// Date: 13 Nov 2016
//
// testbench for scannerState FSM; tests all state transitions
module scannerState_testbench();
	reg clk, reset;
	reg goToStandby, startScan, startTransfer, flush, initialOn;
	reg [3:0] prog;
	wire [2:0] state;

	// set up clock
	parameter CLOCK_PERIOD = 10;
	initial clk = 0;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end

	scannerState dut (.state(state), .initialOn(initialOn), .prog(prog), .goToStandby(goToStandby), .startScan(startScan),
		.startTransfer(startTransfer), .flush(flush), .clk(clk), .reset(reset));

	initial begin
		reset <= 1;																										@(posedge clk);
																														@(posedge clk);
		reset <= 0;	goToStandby <= 0;	startScan <= 0;	startTransfer <= 0;	flush <= 0;	initialOn <= 0; prog <= 4'b0;	@(posedge clk);
																						initialOn <= 1;					@(posedge clk);
					goToStandby <= 1;													initialOn <= 0;					@(posedge clk);
					goToStandby <= 0;																					@(posedge clk);
										startScan <= 1;																	@(posedge clk);
										startScan <= 0;													prog <= 4'b1010;@(posedge clk);
																														@(posedge clk);
														startTransfer <= 1;												@(posedge clk);
														startTransfer <= 0;								prog <= 4'b0;	@(posedge clk);
					goToStandby <= 1;																					@(posedge clk);
					goToStandby <= 0;	startScan <= 1;																	@(posedge clk);
										startScan <= 0;													prog <= 4'b1010;@(posedge clk);
																			flush <= 1;									@(posedge clk);
																			flush <= 0;					prog <= 4'b0;	@(posedge clk);
																														@(posedge clk);
		$finish;
	end

	// gtkwave filedump
	initial begin
		$dumpfile("scannerState.vcd");
		$dumpvars;
	end
endmodule