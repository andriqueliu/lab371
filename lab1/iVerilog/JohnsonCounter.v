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

module johnsonCounter(out,clk, rst);
	input clk, rst;
	output[3:0] out;
	reg [3:0] out;
	
	parameter state0 = 4'b1111;
	parameter state1 = 4'b0111;
	parameter state2 = 4'b0011;
	parameter state3 = 4'b0001;
	parameter state4 = 4'b0000;
	parameter state5 = 4'b1000;
	parameter state6 = 4'b1100;
	parameter state7 = 4'b1110;
	
	always @(posedge clk) 
	begin
	if (~rst)
	begin
	out = state0;
	end
	
	else 
	begin 
	case(out)
	
	state0: 
	out = 4'b0111;
	state1: 
	out = 4'b0011;
	state2: 
	out = 4'b0001;
	state3: 
	out = 4'b0000;
	state4: 
	out = 4'b1000;
	state5: 
	out = 4'b1100;
	state6: 
	out = 4'b1110;
	state7: 
	out = 4'b1111;
	endcase
	end

	end
	
	endmodule