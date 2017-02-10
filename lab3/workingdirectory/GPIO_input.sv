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
	