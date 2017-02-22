// EE371 Lab3 Autumn 2016
// Authors: Dawn Liang, Jun Park, William Li
// Date: 13 Nov 2016
//
// counter that counts every clock edge up/down to a min/max (0/10)
// resets to 0
module counter(data_out, data_in, percentage, up, down, clk, reset);
	output [3:0] percentage;
	input up, down, clk, reset;
	input [7:0] data_in;
	output [7:0] data_out;

	reg [7:0] mem [9:0]; // 10 x 8-bit memory

	// initialise the memory
	initial begin
		ps = 0;
		mem[0] = data_in;
		mem[1] = 8'b0;
		mem[2] = 8'b0;
		mem[3] = 8'b0;
		mem[4] = 8'b0;
		mem[5] = 8'b0;
		mem[6] = 8'b0;
		mem[7] = 8'b0;
		mem[8] = 8'b0;
		mem[9] = 8'b0;
	end

	// combinational logic: count every clock edge
	// min/max set at 0/10
	reg [3:0] ps, ns;
	always@(*) begin
		if (up && ~down && (ps < 10)) begin
			ns = ps + 1;
		end else if (down && ~up && (ps > 0)) begin
			ns = ps - 1;
		end else begin
			ns = ps;
		end
	end

	// output logic
	assign percentage = ps;
	assign data_out = mem[ps];
	
	// sequential logic; reset & next state
	always@(posedge clk) begin
		if (reset) begin 				// clear data
			ps <= 0;
			mem[0] <= 8'b0;
			mem[1] <= 8'b0;
			mem[2] <= 8'b0;
			mem[3] <= 8'b0;
			mem[4] <= 8'b0;
			mem[5] <= 8'b0;
			mem[6] <= 8'b0;
			mem[7] <= 8'b0;
			mem[8] <= 8'b0;
			mem[9] <= 8'b0;
		end else begin
			ps <= ns;
			if (down && ~up) begin 		// erase data
				mem[ps] <= 8'b0;
			end else if (ps < 9) begin 	// save new value
				mem[ps] <= data_in;
			end else begin 				// hold last value (full)
				mem[ps] <= mem[ps];
			end
		end
	end
endmodule
