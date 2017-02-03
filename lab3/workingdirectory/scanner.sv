



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
	
	input  logic level80, level90, level100;
	
	// Register that indicates state/activity status:
	// Low Power, 
	output logic [:0] status;
	output logic readyToTransfer; // 
	output integer bufferAmount;  // 
	
	// 
	dataBuffer dataBuff (.clk, .reset, .level80, .level90, .level100, .bufferAmount);
	
	
	// State Variables
	enum { LOWPOWER, ACTIVESUB80, ACTIVE80, ACTIVE90, ACTIVEFULL,
	       IDLE, TRANSFER, FLUSH } ps, ns;
	
	// Combinational Logic
	// 
	always_comb begin
		case (ps) 
			LOWPOWER: begin
				if (startScanning) begin
					ns = ACTIVESUB80;
					status = 'b10;
				end else begin
					ns = LOWPOWER;
					status = 'b10;
				end
			end
			ACTIVESUB80: begin
				if (level80) begin
					ns = ACTIVE80;
					status = 'b
				end else begin
					ns = ACTIVESUB80;
					status = 'b
				end
			end
			ACTIVE80: begin
				if (level90) begin
					ns = ACTIVE90;
					status = 
				end else begin
					ns = ACTIVE80;
					status = 
				end
			end
			ACTIVE90: begin
				if () begin
					
				end
			end
			ACTIVE100: begin
				
			end
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
