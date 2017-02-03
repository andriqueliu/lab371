



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
module scanner (clk, reset, beginScanning, beginTransfer,
                status, readyToTransfer, bufferAmount,
					 startScanningOut);
	
	input  logic clk, reset;
	input  logic beginScanning, beginTransfer;
	
	// Register that indicates state/activity statuses:
	// Low Power, Scanning, Idle, Transferring, Flush
	output logic [4:0] status;
	output logic readyToTransfer;  // 
	output integer bufferAmount;   // 
	output logic startScanningOut; // 
	
	
	
	// 
	logic level80, level90, level100;
	dataBuffer dataBuff (.clk, .reset, .beginScanning, .level80,
	                     .level90, .level100, .bufferAmount);
	
	// 
	logic  transferComplete;
	transferProcess trans (.clk, .reset, .timerStart(beginTransfer),
	                       .timerComplete(transferComplete));
	
	
	// State Variables
	// Low Power, Active below 80, Active above 80, Active above 90,
	// Active full (100%), 
	enum { LOWPOWER, ACTIVESUB80, ACTIVE80, ACTIVE90,
	       IDLE, TRANSFER } ps, ns;
	
	// Combinational/Next State Logic
	// 
	always_comb begin
		case (ps) 
			LOWPOWER: begin
				if (beginScanning) begin
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
				if (beginTransfer) begin
					ns = TRANSFER;
					status = 5'b00100;
				end else begin
					ns = IDLE;
					status = 5'b00100;
				end
			end
			TRANSFER: begin
				if (transferComplete) begin
					ns = LOWPOWER;
					status = 5'b00010;
				end else begin
					ns = TRANSFER;
					status = 5'b00010;
				end
			end
//			FLUSH: begin
//				if () begin
//					
//					status = 5'b00001;
//				end else begin
//					
//					status = 5'b00001;
//				end
//			end
			default: begin
				ns = LOWPOWER;
				status = 5'bX;
			end
		endcase
		
		// Once the scanner becomes ACTIVE, initiate the data collection process.
		
		// Once the scanner is in the TRANSFER state, initiate transfer process.
		
		// Once the data buffer is 90% full, tells the other scanner to
		// start scanning. 
		if (ps == ACTIVE90) begin // ??? 
			startScanningOut = 1;
		end else begin
			startScanningOut = 0;
		end
		
		
	end
	
	
	
	// Sequential Logic
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= LOWPOWER;
		end else begin
			ps <= ns;
		end
	end
	
endmodule

// Test Module
module scanner_testbench();
	logic clk, reset;
	logic beginScanning, beginTransfer;
	
	// Register that indicates state/activity statuses:
	// Low Power, Scanning, Idle, Transferring, Flush
	logic [4:0] status;
	logic readyToTransfer; // 
	integer bufferAmount;  // 
	logic startScanningOut;
	
	scanner dut (clk, reset, beginScanning, beginTransfer,
                status, readyToTransfer, bufferAmount,
					 startScanningOut);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	reset <= 1; 			  @(posedge clk);
								  @(posedge clk);
	reset <= 0;            @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	beginScanning <= 1;    @(posedge clk);
	beginScanning <= 0;    @(posedge clk);
	repeat (80) @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	beginTransfer <= 1;    @(posedge clk);
	beginTransfer <= 0;    @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule
