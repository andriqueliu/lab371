//GPIO module

module GPIO_input(clk, rst, clkIN, serIN, readyOUT, data, load);

	input clk, rst;

	//This represents the GPIO
	input clkIN, serIN;
	output readyOUT;

	//data out
	output reg[7:0] data
	output reg load;

	reg acceptingSerial;
	assign readyOUT = acceptingSerial;
	reg [4:0] serialBitsLeft;

	always @(posedge clk) begin
		if (rst) begin
				data <= 8'b00000000;
				load <= 0;
				acceptingSerial <= 1;
				serialBitsLeft <= 8;
		end else begin
			if (acceptingSerial) begin
				if(clkIN) begin
					data[0] <= serIN;
					data[1] <= data[0];
					data[2] <= data[1];
					data[3] <= data[2];
					data[4] <= data[3];
					data[5] <= data[4];
					data[6] <= data[5];
					data[7] <= data[6];

					if(serialBitsLeft > 1) begin
						serialBitsLeft <= serialBitsLeft - 1;
					end else begin
						serialBitsLeft <= 0;
						acceptingSerial <= 0;
					end
				end
			end
		end
	end
endmodule

module GPIO_inputTest;
	reg clk, rst;
	reg serIN, clkIN;
	wire readyOUT;
	wire [7:0] data;
	wire load;

	GPIO_input dut(clk, rst, serIN, readyOUT, data, load);

	//test
	integer i;
	reg [7:0] testData;
	initial begin
		{clk, clkIN, serIN, rst} = 0;

		clk = 1; #2;
		clk = 0; #2;
		rst = 1;
		clk = 1; #2;
		clk = 0; #2;
		rst = 0;
		clk = 1; #2;
		clk = 0; #2;

		// get some random data
		testData = 8'b10010111;
		for (i = 0; i < 8; i = i + 1) begin
			serIN = testData[7 - i];
			clk = 1; clkIN = 1; #2;
			clk = 0; clkIN = 0; #2;
		end

		for (i = 0; i < 8; i = i + 1) begin
			clk = 1; #2;
			clk = 0; #2;
		end

		// get all 0's
		testData = 8'b00000000;
		for (i = 0; i < 8; i = i + 1) begin
			serIN = testData[7 - i];
			clk = 1; clkIN = 1; #2;
			clk = 0; clkIN = 0; #2;
		end

		for (i = 0; i < 8; i = i + 1) begin
			clk = 1; #2;
			clk = 0; #2;
		end

		// get all 1's
		testData = 8'b11111111;
		for (i = 0; i < 8; i = i + 1) begin
			serIN = testData[7 - i];
			clk = 1; clkIN = 1; #2;
			clk = 0; clkIN = 0; #2;
		end

		for (i = 0; i < 8; i = i + 1) begin
			clk = 1; #2;
			clk = 0; #2;
		end

		// slightly off clk cycles
		// TODO test for lab 5

		$finish;
	end 
	
endmodule