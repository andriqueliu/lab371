module DFlipFlop(q, qBar, D, clk, rst);
	input D, clk, rst;
	output q, qBar;
	reg q;
	not n1 (qBar, q);
	always@ (negedge rst or posedge clk)
		begin
		if(!rst)
		q = 0;
		else
	q = D;
	end
endmodule

module clkDivider(clk, clk_out);
output clk_out;
input clk; // connect to system 50 MHz clock
reg [25:0] tBase; // system time base
always@(posedge clk) 
begin
tBase <= tBase + 1'b1;
clk_out <= tBase[25];
end
endmodule 

module rippleDown(qOut, clk, rst);

	input clk, rst;
	output [3:0] qOut;
	wire [3:0] Qbar;
	wire clock;
	
	clkDivider newClock (.clk(clk), .clk_out(clock));

	DFlipFlop ff0 (.q(qOut[0]), .qBar(Qbar[0]), .D(Qbar[0]), .clk(clock), .rst(rst));
	DFlipFlop ff1 (.q(qOut[1]), .qBar(Qbar[1]), .D(Qbar[1]), .clk(qOut[0]), .rst(rst));
	DFlipFlop ff2 (.q(qOut[2]), .qBar(Qbar[2]), .D(Qbar[2]), .clk(qOut[1]), .rst(rst));
	DFlipFlop ff3 (.q(qOut[3]), .qBar(Qbar[3]), .D(Qbar[3]), .clk(qOut[2]), .rst(rst));

endmodule
