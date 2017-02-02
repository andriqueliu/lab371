



// Ideally, there should be one transfer signal for the whole system. But I used two for now out of convenience 
// for each of the two buffers

/*
EE 371 Winter 2017
Lab 3 Project
Authors: Emraj Sidhu, Andrique Liu, Nikhil Grover

Finite State Machine for the Scanner 



*/
module scanner (clk, reset, standBySig, startScanning, transferCmd, secondTransferCmd, transComplete, flush, stateOut );
	input  logic clk, reset;
	input  logic standBySign, startScanning, transfer, secondTransferCmd, transComplete, flush;
	
	input  logic startActive; // Flag that indicates when STANDBY is complete
	
	// Register that indicates state/activity status:
	// Low Power, 
	output logic [:0] status;
	
	dataBuffer dataBuff (.clk, .reset, .level80(), .level90(), .level100());
	beginActiveCounter activeCt(.clk, .reset, .startStandby(status[]), .startActive);
	

	
	
	
	
	
	
	// State Variables
	enum { LOWPOWER, STANDBY, ACTIVE, IDLE, TRANSFER, FLUSH } ps, ns;
	
	// Combinational Logic
	always_comb begin
		case (ps) 
			LOWPOWER: begin
				if (startScanning) begin
					ns = STANDBY;
					status = 'b10
				end else begin
					ns = LOWPOWER;
					status = 'b10
				end
			end
		   STANDBY: begin
				if (startActive) begin
					ns = ACTIVE;
					status = 'b01
				end else begin
					ns = STANDBY;
					status = 'b01
				end
			end
			ACTIVESUB80:
				if (transferCmd)
					ns = transfer; 
				else if (!transferCmd)
					ns = idle;
				else
					ns = ps;
			ACTIVE80:
			ACTIVE90:
			ACTIVEFULL:
			idle:
				if (secondTransferCmd)
					ns = transfer;
				else if (flush)
					ns = flushing;
				else
					ns = ps;
			transfer:
				if (transComplete)
					ns = lowPower;
			   else
					ns = ps;
			flushing:
				if (transComplete)
					ns = lowPower;
				else
					ns = ps;
			default:
				
	  endcase

	// Assign output
	assign stateOut = ps;
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= LOWPOWER;
			beginActive <= 0;
		end else begin
			ps <= ns;
		end
	end
	
endmodule
