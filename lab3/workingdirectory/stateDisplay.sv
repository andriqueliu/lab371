/*




*/
module stateDisplay (clk, reset, startScanning, startTransfer, address, HEX);
	input  logic clk, reset;
	input  logic startScanning, startTransfer;
	input  integer address;
	
	output logic [6:0] HEX;
	
	logic  [6:0] lowPower, scanning, transferring;
	assign lowPower = ~(7'b0111000);
	assign scanning = ~(7'b1101101);
	assign transferring = ~(7'b1110111);
	
	
	// State variables.
	enum { LP, SCAN, TRANSFER } ps, ns;
	
	// Next State logic
	// 
	always_comb begin
		case (ps)
			LP: begin
				if (address == 0 && startScanning) begin
					ns = SCAN;
					HEX = scanning;
				end else if (address == 749 && startTransfer) begin
					ns = TRANSFER;
					HEX = transferring;
				end else begin
					ns = LP;
					HEX = lowPower;
				end
			end
			SCAN: begin
				if (address == 749) begin
					ns = LP;
					HEX = lowPower;
				end else begin
					ns = SCAN;
					HEX = scanning;
				end
			end
			TRANSFER: begin
				if (address == -1) begin
					ns = LP;
					HEX = lowPower;
				end else begin
					ns = TRANSFER;
					HEX = transferring;
				end
			end
			default: begin
				
			end
		endcase
	end
	
	// 
	// 
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= LP;
		end else begin
			ps <= ns;
		end
	end
	
	
endmodule
