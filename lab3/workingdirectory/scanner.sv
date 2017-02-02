



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
	
	// Register that indicates state/activity status:
	// Low Power, 
	output logic [:0] status;
	
	dataBuffer dataBuff (.clk, .reset, .level80(), .level90(), .level100());
	beginActiveCounter activeCt(.clk, .reset, .startStandby(status[]), .startActive);
	
	integer  beginActive; // Flag that enables ACTIVE following delay after STANDBY
	
	// Initial Logic
	// 
	initial begin
		beginActive = 0;
	end
	
	
	
	
	
	
	// State Variables
	enum { LOWPOWER, STANDBY, ACTIVE, IDLE, TRANSFER, FLUSH } ps, ns;
	
	// Combinational Logic
	always_comb begin
		case (ps) 
			LOWPOWER:
				if (startScanning)
					ns = STANDBY;
				else
					ns = LOWPOWER;
					status = 'b10
		   STANDBY:
				if (startScanning)
					ns = scanning;
				else
					ns = ps;
			scanning:
				if (transferCmd)
					ns = transfer; 
				else if (!transferCmd)
					ns = idle;
				else
					ns = ps;
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
