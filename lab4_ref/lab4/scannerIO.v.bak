module scanner_io(HEX, KEY, LED, SW, clk, rst);
	input clk, rst;
	input [7:0] SW;
	input [3:0] KEY;
	output [7:0] LED;
	output [6:0] HEX [5:0];

	// scanner i/o signals
	wire [7:0] s1_data_out, s1_data_in, s2_data_out, s2_data_in;
	wire [2:0] s1_state, s2_state;
	wire [3:0] s1_buffer_progress, s2_buffer_progress;

	// scanner/scanner interaction signals
	wire	s1_readyToTransfer, s2_readyToTransfer,
			s1_otherGoToStandby, s2_otherGoToStandby,
			s1_otherStartScan, s2_otherStartScan,
			s1_otherFlush, s2_otherFlush;

	// scanner/processor interaction signals
	wire startScanning, transfer, readyToTransfer;
	readyToTransfer = s1_readyToTransfer || s2_readyToTransfer;

	assign s1_data_in = s1_buffer_progress; // input data is just the address of the mem slot
	assign s2_data_in = s2_buffer_progress;

	scanner s1 (.data_out(s1_data_out), .buffer_progress(s1_buffer_progress), .state(s1_state), .readyToTransfer(s1_readyToTransfer),
		.otherGoToStandby(s1_otherGoToStandby), .otherStartScan(s1_otherStartScan), .otherFlush(s1_otherFlush),
		.data_in(s1_data_in), .whichScanner(1), .initialOn(startScanning), .goToStandby(s2_otherGoToStandby),
		.startScan(s2_otherStartScan), .startTransfer(transfer), .flush(s2_otherFlush), .clk(clk), .reset(rst));
	scanner s2 (.data_out(s2_data_out), .buffer_progress(s2_buffer_progress), .state(s2_state), .readyToTransfer(s2_readyToTransfer),
		.otherGoToStandby(s2_otherGoToStandby), .otherStartScan(s2_otherStartScan), .otherFlush(s2_otherFlush),
		.data_in(s2_data_in), .whichScanner(0), .initialOn(startScanning), .goToStandby(s1_otherGoToStandby),
		.startScan(s1_otherStartScan), .startTransfer(transfer), .flush(s1_otherFlush), .clk(clk), .reset(rst));

	nios2 processor (.clk, .rst);
	// takes readyToTransfer from scanner subsystem
	// sends startScanning and transfer to scanner subsystem

	// display ctrl & status lines to red LEDs
	// display the input data & transfer data onto HEX displays
endmodule
