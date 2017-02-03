



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
	logic  beginTransfer;
	logic  transferComplete;
	
	// 
	dataBuffer dataBuff (.clk, .reset, .level80, .level90, .level100, .bufferAmount);
	
	// 
	transferProcess trans (.clk, .reset, .timerStart(beginTransfer),
	                       .timerComplete(transferComplete));
	
	// 
	initial begin
		beginTransfer = 0;
	end
	
	// State Variables
	// Low Power, Active below 80, Active above 80, Active above 90,
	// Active full (100%), 
	enum { LOWPOWER, ACTIVESUB80, ACTIVE80, ACTIVE90,
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
				if (level100) begin
					ns = IDLE;
					status = 5'b01000;
				end else begin
					ns = ACTIVE90;
					status = 5'b01000;
				end
			end
			IDLE: begin
				if (transfer) begin
					ns = TRANSFER;
					status = 
				end else begin
					ns = IDLE;
					status = 
				end
			end
			TRANSFER: begin
				if (transferComplete) begin
					ns = LOWPOWER;
					status = 
				end else begin
					ns = TRANSFER;
					status = 
				end
			end
			FLUSH: begin
				if () begin
					
					
				end else begin
					
					
				end
			end
			default: begin
				ns = LOWPOWER
				status = X; // ??? 
			end
		endcase
		
		if (ps = TRANSFER) begin
			beginTransfer = 1;
		end else begin
			beginTransfer = 0;
		end
		
	end
		

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
