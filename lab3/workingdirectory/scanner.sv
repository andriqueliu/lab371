// EE 371 Winter 2017
//Authors: Emraj Sidhu, Andrique Liu, Nikhil Grover 
//Finite State Machine for the scanner

//The scanning state in the FSM may need some work. Directions for that are a bit confusing
//We may have too many or the completely wrong inputs. We need to talk about the databuffer module and
//how the rest of the system will be designed.

//Ideally, there should be one transfer signal for the whole system. But I used two for now out of convenience 
// for each of the two buffers

module scanner (clk, reset, standBySig, startScanning, transferCmd, secondTransferCmd, transComplete, flush, stateOut );
	input  logic clk, reset;
	input  logic standBySign, startScannning, transferCmd, secondTransferCmd, transComplete, flush;
	
	output logic stateOut; //is output going to hex????
	
	
	
	
	dataBuffer dataBuff (.clk, .reset, .level80(), .level90(), .level100());
	
	reg [2:0] ps;
	reg [2:0] ns;
	
	parameter lowPower = 3'b000, standby = 3'b001, scanning = 3'b010, idle = 3'b011, transfer = 3'b100,
				 flushing = 3'b101;
	
	// Present state to next state logic
	always@(*) 
		case(ps) 
			lowPower : if (standBySig)        ns = standby;
				        else                   ns = ps;
		   standby:   if (startScanning)     ns = scanning;
						  else                   ns = ps;
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
	

	//assign output
	assign stateOut = ps;
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= lowPower;	
		end else begin
			ps <= ns;
		end
	end
	
endmodule
 
 