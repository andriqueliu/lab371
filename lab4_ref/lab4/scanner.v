// EE371 Lab4 Winter 2017
// Authors: Andrique Liu, Emraj Sidhu, Nikhil Grover
// Date: 
// 
// scanner module including FSM and counter for control and memory systems
// outputs current state & buffer progress, and control signals for other
// scanner
module scanner(data_out, buffer_progress, state, readyToTransfer, otherGoToStandby, otherStartScan, otherFlush,
				data_in, whichScanner, initialOn, goToStandby, startScan, startTransfer, flush, clk, reset);
	input clk, reset;
	input initialOn, goToStandby, startScan, startTransfer, flush, whichScanner;
	input [7:0] data_in;

	output readyToTransfer, otherGoToStandby, otherStartScan, otherFlush;
	output [3:0] buffer_progress;
	output [2:0] state;
	output [7:0] data_out;
	
	parameter scanning = 3'b010;

	scannerState ctrl (.state(state), .whichScanner(whichScanner), .initialOn(initialOn), .goToStandby(goToStandby), .startScan(startScan),
		.prog(buffer_progress), .startTransfer(startTransfer), .flush(flush), .clk(clk), .reset(reset));
	dataBuffer mem (.data_out(data_out), .data_in(data_in), .percentage(buffer_progress), .state(state), .clk(clk), .reset(reset));

	assign readyToTransfer = (buffer_progress == 5 && state == scanning);
	assign otherGoToStandby = (buffer_progress == 8 && state == scanning);
	assign otherStartScan = (buffer_progress == 9 && state == scanning);
	assign otherFlush = (buffer_progress == 5 && state == scanning);
endmodule
