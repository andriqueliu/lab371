// EE371 Lab3 Autumn 2016
// authors: William Li, Dawn Liang, Jun Park
// date: 13 Nov 2016
// 
// clock divider module: outputs a 32-bit counter bus
//    choose the clock speed by choosing the bit
module clock_divider (divided_clocks, clk);
	input clk;
	output [31:0] divided_clocks;

	reg [31:0] clocks;
	initial clocks = 0;

	always@(posedge clk) begin
		clocks <= clocks + 1'b1;
	end

	assign divided_clocks = clocks;
endmodule