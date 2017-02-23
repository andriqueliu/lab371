// Andrique Liu

// FSM: two inputs and three LEDR outputs
module lol_fsm (clk, reset, SW, LEDR);
	input  logic 		 clk, reset;
	input  logic [1:0] SW;
	output logic [2:0] LEDR;
	
	// State variables.
	enum { C1, C2, L1, L2, L3, R1, R2, R3 } ps, ns;
	
	// Next State logic
	// Reserved for complex logic
	always_comb begin
		case (SW)
			2'b00: begin
				if (ps == C1) begin // 
					ns = C2;
					LEDR = 3'b010;
				end else begin		  // If you're at C2 or you're at any OTHER state
					ns = C1;
					LEDR = 3'b101;
				end
			end
			2'b01: begin
				if (ps == L1) begin
					ns = L2;
					LEDR = 3'b010;
				end else if (ps == L2) begin
					ns = L3;
					LEDR = 3'b100;
				end else begin	     // If you're at L3 or you're at any OTHER state
					ns = L1;
					LEDR = 3'b001;
				end
			end
			2'b10: begin
				if (ps == R1) begin
					ns = R2;
					LEDR = 3'b010;
				end else if (ps == R2) begin
					ns = R3;
					LEDR = 3'b001;
				end else begin		  // If you're at R3 or you're at any OTHER state
					ns = R1;
					LEDR = 3'b100;
				end
			end
			default: begin			  // If IMPOSSIBLE input is reached
				ns = C1;
				LEDR = 3'bX;
			end
		endcase
	end
	
	// Output logic - could also be another always, or part of above block.
	
//	assign out = (ps == C);
	
	// DFFs
	// !!! This means: only execute when you see a posedge of clk
	// Reserved for simple statements
	always_ff @(posedge clk)
		if (reset)
			ps <= C1;
		else
			ps <= ns;

endmodule

// To simulate, you not only have to provide the inputs, but you also
// have to specify the clock, hence the testbench
module test_fsm_testbench();
	logic clk, reset;
	logic [1:0] SW;
	logic [2:0] LEDR;
	
	hzd_fsm dut (clk, reset, SW, LEDR);
		
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
								  @(posedge clk);		// !!! you wait for a posedge (and thus FSM)
	            			  @(posedge clk);		// moves to the next state) before applying
								  @(posedge clk);		// new inputs
								  @(posedge clk);
								  @(posedge clk);    // #5 !!! right after the 5th posedge, SW = 2'b00!!!
	SW = 2'b00;  	     	  @(posedge clk);    // Wait for 5 posedges, then apply that input
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);    // !!! See the effects of 00 for 5 periods...
								  @(posedge clk);		// ... which ends at this line
	SW = 2'b01;			     @(posedge clk);    // After 10 pes, put this input in
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	SW = 2'b10;			     @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	SW = 2'b00;				  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	SW = 2'b10;				  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
								  @(posedge clk);
	$stop; // End the simulation.
	end
endmodule