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

module syncDown(qOut, clk, rst);

	input clk, rst;
	output [3:0] qOut;
	wire d0, d1, d2, d3;
	wire [3:0] Qbar;
	
	assign d0 = Qbar[0];
	assign d1 = ~(qOut[1] ^ qOut[0]);
	assign d2 = ~(qOut[2] ^ (qOut[1] | qOut[0]));
	assign d3 = ~(qOut[3] ^ (qOut[2] | qOut[1] | qOut[0]));

	DFlipFlop ff0 (.q(qOut[0]), .qBar(Qbar[0]), .D(d0), .clk(clk), .rst(rst));
	DFlipFlop ff1 (.q(qOut[1]), .qBar(Qbar[1]), .D(d1), .clk(clk), .rst(rst));
	DFlipFlop ff2 (.q(qOut[2]), .qBar(Qbar[2]), .D(d2), .clk(clk), .rst(rst));
	DFlipFlop ff3 (.q(qOut[3]), .qBar(Qbar[3]), .D(d3), .clk(clk), .rst(rst));

endmodule
