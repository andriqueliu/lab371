	`include "syncDown.v"
	module testBench;
	 // connect the two modules
	 wire clk, rst;
	 wire [3:0] q;
	 
	// declare an instance of the AND module
	 syncDown counter (.qOut(q), .clk(clk), .rst(rst));

	// declare an instance of the testIt module
	 Tester aTester (.qOut(q), .clk(clk), .rst(rst));
	 
	endmodule 

	module Tester (qOut, clk, rst);

	 input [3:0] qOut;
	 output clk,rst;
	 reg D, clk, rst;
	 parameter period = 5;
	 parameter stimDelay = 20;
	 
	 always
		#period clk = ~clk;

		initial 
		begin
		clk = 0;
		rst = 0;
		end
		
	   initial
		begin
	// these two files support gtkwave and are required
	 $dumpfile("syncDown.vcd");
	 $dumpvars;
	 end
	 
	 always @(posedge clk) 
	 begin
	 $monitor($time, "qOut = %b", qOut);
	 
	 repeat(2)
	 begin 
	 #stimDelay rst = 0;
	 #stimDelay rst = 1;
	 #stimDelay rst = 1;
	 #stimDelay rst = 1;
	 end
	 
	 #(20*period); // needed to see END of simulation
	 $stop;
	 $finish; // finish simulation
	 end
	endmodule 
