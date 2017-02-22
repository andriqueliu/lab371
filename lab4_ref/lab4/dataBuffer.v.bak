// EE371 Lab 4 Autumn 2016
// Authors: Jun Park William Li Dawn Liang
// Date: 
//
// controls a counter that counts up/down at different speeds depending on
// the state input
`include "clock_divider.v"
`include "counter.v"
module dataBuffer(data_out, data_in, percentage, state, clk, reset);
	input [2:0] state;
	input [7:0] data_in;
	input clk, reset;

	output [7:0] data_out;
	output [3:0] percentage;

	// state encodings
	parameter	lowPower = 3'b000,
				standby = 3'b001,
				scanning = 3'b010,
				idle = 3'b011,
				xferring = 3'b100,
				flushing = 3'b101;

	// clock division
	wire [31:0] divided_clocks;
	clock_divider div (.divided_clocks(divided_clocks), .clk(clk));
	reg final_clock;

	// control signals
	reg up, down;
	always@(*) begin
		case (state)
			lowPower:	begin
							final_clock = divided_clocks[0];
							up = 0; down = 0;
						end
			standby:	begin
							final_clock = divided_clocks[0];
							up = 0; down = 0;
						end
			scanning:	begin 									// count up at 1x speed
							final_clock = divided_clocks[2];
							up = 1; down = 0;
						end
			idle:		begin
							final_clock = divided_clocks[0];
							up = 0; down = 0;
						end
			xferring:	begin 									// count down at 4x speed
							final_clock = divided_clocks[1];
							up = 0; down = 1;
						end
			flushing:	begin 									// count down at 8x speed
							final_clock = divided_clocks[0];
							up = 0; down = 1;
						end
			default:	begin
							final_clock = divided_clocks[0];
							up = 0; down = 0;
						end
		endcase
	end

	// counter
	counter prog (.data_out(data_out), .data_in(data_in), .percentage(percentage), .up(up), .down(down), .clk(final_clock), .reset(reset));
endmodule
