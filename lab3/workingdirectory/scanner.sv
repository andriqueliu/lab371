// EE 371 Winter 2017
// Authors: Emraj Sidhu, Andrique Liu, Nikhil Grover 
// Finite State Machine for the scanner

// The scanning state in the FSM may need some work. Directions for that are a bit confusing
// We may have too many or the completely wrong inputs. We need to talk about the databuffer module and
// how the rest of the system will be designed.

// Ideally, there should be one transfer signal for the whole system. But I used two for now out of convenience 
// for each of the two buffers

module scanner (clk, reset, standBySig, startScanning, transferCmd, secondTransferCmd, transComplete, flush, stateOut );
	input  logic clk, reset;
	input  logic standBySign, startScanning, transferCmd, secondTransferCmd, transComplete, flush;
	
	output logic stateOut; //is output going to hex????
	
	
	
	
	dataBuffer dataBuff (.clk, .reset, .level80(), .level90(), .level100());
	
	// State Variables
	enum { LOWPOWER, STANDBY, SCANNING, IDLE, TRANSFER, FLUSH } ps, ns;
	
	// Combinational Logic
	always_comb begin
		case (ps) 
			lowPower:
				if (standBySig)
					ns = standby;
				else
					ns = ps;
		   standby:
				if (startScanning)
					ns = scanning;
				else
					ns = ps;
			scanning:  if (transferCmd)       ns = transfer; 
						  else if (!transferCmd) ns = idle;
						  else                   ns = ps;
			idle:      if (secondTransferCmd) ns = transfer;
						  else if (flush)        ns = flushing;
				        else                   ns = ps;
			transfer:  if (transComplete)     ns = lowPower;
			           else                   ns = ps;
			flushing:  if (transComplete)     ns = lowPower;
						  else                   ns = ps;
			default:                          ns = 3'bxxx
	  endcase

	// Assign output
	assign stateOut = ps;
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= LOWPOWER;
		end else begin
			ps <= ns;
		end
	end
	
endmodule
