/*




*/
module encoder (clk, reset, column, select);
	input  logic clk, reset;
	input  logic [6:0] column;
	
	output logic [2:0] select;
	
	always_comb begin
		case (column)
			7'b0000001: begin
				select = 3'b001;
			end
			7'b0000010: begin
				select = 3'b010;
			end
			7'b0000100: begin
				select = 3'b011;
			end
			7'b0001000: begin
				select = 3'b100;
			end
			7'b0010000: begin
				select = 3'b101;
			end
			7'b0100000: begin
				select = 3'b110;
			end
			7'b1000000: begin
				select = 3'b111;
			end
			default: begin
				select = 3'bXXX;
			end
		endcase
	end
	
endmodule

// Tester Module
module encoder_testbench();
	logic clk, reset;
	logic [7:0] column;
	
	logic [2:0] select;
	
	encoder dut (clk, reset, column, select);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);
	column <= 8'b00001000;							  @(posedge clk);
								  @(posedge clk);
	column <= 8'b00000001;							  @(posedge clk);
								  @(posedge clk);
	column <= 8'b10000000;							  @(posedge clk);
								  @(posedge clk);
	column <= 8'b00000010;							  @(posedge clk);
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
