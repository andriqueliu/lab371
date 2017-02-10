module GPIO_output (clk, rst, data, load, clkOUT, serOUT, readyIN);
	// system input
	input clk, rst;

	// data to send input
	input [7:0] data;
	input load;

	// GPIO input and output
	output reg clkOUT, serOUT;
	input readyIN;
	
	// internal state
	reg hasDataToSend;
	reg [2:0] bitsLeftToSend;
	reg [6:0] dataBuffer;
	
	always @(posedge clk) begin
		if (rst) begin
			hasDataToSend <= 0;
			bitsLeftToSend <= 0;
			dataBuffer <= 0;
			clkOUT <= 0;
			serOUT <= 0;
		end else begin
			if (hasDataToSend) begin
				if (clkOUT == 1) begin
					dataBuffer[0] <= 1'b0;
					dataBuffer[1] <= dataBuffer[0];
					dataBuffer[2] <= dataBuffer[1];
					dataBuffer[3] <= dataBuffer[2];
					dataBuffer[4] <= dataBuffer[3];
					dataBuffer[5] <= dataBuffer[4];
					dataBuffer[6] <= dataBuffer[5];
					serOUT <= dataBuffer[6];
					clkOUT <= 0;

					if (bitsLeftToSend > 0) begin
						bitsLeftToSend <= bitsLeftToSend - 1;
					end else begin
						hasDataToSend <= 0;
					end
				end else begin
					clkOUT <= 1;
				end
			
			end else begin
				if (load) begin
					dataBuffer <= data[6:0];
					serOUT <= data[7];
					hasDataToSend <= 1;
					bitsLeftToSend <= 7;
				end
			end
		end
	end
endmodule

module GPIO_outputTest;

	reg clk, rst;
	reg [7:0] data;
	reg load;

	// GPIO input and output
	wire clkOUT, serOUT;
	reg readyIN;

	// instantiate module to test
	GPIO_output dut(
			clk, rst, data, load, clkOUT, serOUT, readyIN
	);

	// stuff needed for gtkwave
	initial begin
		$dumpfile("dumpfile.vcd");
		$dumpvars(1, dut);
	end

	//test
	integer i;
	reg [7:0] testData;
	initial begin
		{clk, rst, data, load, readyIN} = 0;

		clk = 1; #2;
		clk = 0; #2;
		rst = 1;
		clk = 1; #2;
		clk = 0; #2;
		rst = 0;
		clk = 1; #2;
		clk = 0; #2;

		readyIN <= 1;

		// send some random data
		data <= 8'b10010111;
		load <= 1;
			clk = 1; #2;
			clk = 0; #2;
		data <= 0;
		load <= 0;
		for (i = 0; i < 32; i = i + 1) begin
			clk = 1; #2;
			clk = 0; #2;
		end

		// send 0's
		data <= 8'b00000000;
		load <= 1;
			clk = 1; #2;
			clk = 0; #2;
		data <= 0;
		load <= 0;
		for (i = 0; i < 32; i = i + 1) begin
			clk = 1; #2;
			clk = 0; #2;
		end

		// send 1's
		data <= 8'b11111111;
		load <= 1;
			clk = 1; #2;
			clk = 0; #2;
		data <= 0;
		load <= 0;
		for (i = 0; i < 32; i = i + 1) begin
			clk = 1; #2;
			clk = 0; #2;
		end

		$finish;
	end		
endmodule