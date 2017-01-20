// RippleDown.v
// EE 371 Lab 1 Project
//	RippleDown controls a counter operating in a ripple down pattern
//	Authors: Nikhil Grover, Emraj Sidhu, Andrique Liu
module RippleDown(qOut, clk, rst);

	input clk, rst;
	output [3:0] qOut;
	wire [3:0] Qbar;

	DFlipFlop ff0 (.q(qOut[0]), .qBar(Qbar[0]), .D(Qbar[0]), .clk(clk), .rst(rst));
	DFlipFlop ff1 (.q(qOut[1]), .qBar(Qbar[1]), .D(Qbar[1]), .clk(qOut[0]), .rst(rst));
	DFlipFlop ff2 (.q(qOut[2]), .qBar(Qbar[2]), .D(Qbar[2]), .clk(qOut[1]), .rst(rst));
	DFlipFlop ff3 (.q(qOut[3]), .qBar(Qbar[3]), .D(Qbar[3]), .clk(qOut[2]), .rst(rst));

endmodule
