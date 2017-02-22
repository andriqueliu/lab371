// EE371 Lab4 Winter 2017
// Authors: Andrique Liu, Emraj Sidhu, Nikhil Grover
// Date:
//
// FSM controlling the state of the scanner
module scannerState(state, whichScanner, initialOn, goToStandby, startScan, prog, startTransfer, flush, clk, reset);
	output [2:0] state;
	input whichScanner, initialOn, goToStandby, startScan, startTransfer, flush;
	input [3:0] prog;
	input clk, reset;

	// state encodings
	parameter	lowPower = 3'b000,
				standby = 3'b001,
				scanning = 3'b010,
				idle = 3'b011,
				xferring = 3'b100,
				flushing = 3'b101;

	// combinational logic: next state
	reg [2:0] ps, ns;
	reg active;
	always@(*) begin 				// cycling between scanners
		if (active) begin
			case (ps)
				lowPower:	begin
								if (goToStandby) ns = standby;
								else ns = ps;
							end
				standby:	begin
								if (startScan) ns = scanning;
								else ns = ps;
							end
				scanning:	begin
								if (prog == 4'b1010) ns = idle;
								else ns = ps;
							end
				idle:		begin
								if (startTransfer) ns = xferring;
								else if (flush) ns = flushing;
								else ns = ps;
							end
				xferring:	begin
								if (prog == 4'b0) ns = lowPower;
								else ns = ps;
							end
				flushing:	begin
								if (prog == 4'b0) ns = lowPower;
								else ns = ps;
							end
				default:	ns = ps;
			endcase
		end else begin 					// initialising: start the scanner cycles
			if (initialOn) begin
				if (whichScanner) ns = scanning;
				else ns = lowPower;
			end else begin
				ns = lowPower;
			end
		end
	end

	// output logic
	assign state = ps;

	// sequential logic: reset, next state
	always@(posedge clk) begin
		if (reset) begin
			ps <= lowPower;
			active <= 0;
		end else begin
			ps <= ns;
			if(initialOn) active <= 1;
			else active <= active;
		end
	end
endmodule
