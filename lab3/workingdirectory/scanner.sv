



// Ideally, there should be one transfer signal for the whole system. But I used two for now out of convenience 
// for each of the two buffers

/*
EE 371 Winter 2017
Lab 3 Project
Authors: Emraj Sidhu, Andrique Liu, Nikhil Grover

Finite State Machine for the Scanner 


Note: "Low Power" and "Standby" combined into one state, as there is no mention
of a transition between the two states within the lab specification.
*/
module scanner (clk, reset, standBySig, startScanning, transferCmd, secondTransferCmd, transComplete, flush, stateOut );
	input  logic clk, reset;
	input  logic standBySign, startScanning, transfer, secondTransferCmd, transComplete, flush;
	
	input  logic level80, level90, level100;
	
	// Register that indicates state/activity statuses:
	// Low Power, Scanning, Idle, Transferring, Flush
	output logic [4:0] status;
	output logic readyToTransfer; // 
	output integer bufferAmount;  // 
	
	// 
	dataBuffer dataBuff (.clk, .reset, .level80, .level90, .level100, .bufferAmount);
	
	
	// State Variables
	// Low Power, Active below 80, Active above 80, Active above 90,
	// Active full (100%), 
	enum { LOWPOWER, ACTIVESUB80, ACTIVE80, ACTIVE90, ACTIVEFULL,
	       IDLE, TRANSFER, FLUSH } ps, ns;
	
	// Combinational/Next State Logic
	// 
	always_comb begin
		case (ps) 
			LOWPOWER: begin
				if (startScanning) begin
					ns = ACTIVESUB80;
					status = 5'b10000;
				end else begin
					ns = LOWPOWER;
					status = 5'b10000;
				end
			end
			ACTIVESUB80: begin
				if (level80) begin
					ns = ACTIVE80;
					status = 5'b01000;
				end else begin
					ns = ACTIVESUB80;
					status = 5'b01000;
				end
			end
			ACTIVE80: begin
				if (level90) begin
					ns = ACTIVE90;
					status = 5'b01000;
				end else begin
					ns = ACTIVE80;
					status = 5'b01000;
				end
			end
			ACTIVE90: begin
				if () begin
					
				end else begin
					
				end
			end
			ACTIVE100: begin
				if () begin
				
				end
			end
			IDLE: begin
			
			end
			TRANSFER: begin
			
			end
			FLUSH:
				
			default:
				
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
