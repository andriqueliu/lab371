///*
//
//
//
//
//*/
//module node (clk, reset, node_available, drop_red, drop_green,
//             red_on, green_on);
//	input  logic clk, reset;
//	input  logic node_available;
//	input  logic drop_red, drop_green;
//	
//	output logic red_on, green_on;
//	
//	// State Variables
//	enum { OFF, RED, GREEN } ps, ns;
//	
//	// 
//	// 
//	always_comb begin
//		case (ps)
//			OFF: begin
//				if (available && drop_red) begin
//					ns = RED;
//				end else if (available && drop_green) begin
//					ns = GREEN;
//				end else begin
//					ns = OFF;
//				end
//				red_on = 0;
//				green_on = 0;
//			end
//			
//			RED: begin
//				ns = RED;
//				red_on = 1;
//				green_on = 0;
//			end
//			
//			GREEN: begin
//				ns = GREEN;
//				red_on = 0;
//				green_on = 1;
//			end
//		endcase
//	end
//	
//	// Sequential Logic
//	// 
//	always_ff @(posedge clk) begin
//		if (reset) begin
//			ps <= OFF;
//		end else begin
//			ps <= ns;
//		end
//	end
//	
//endmodule
//
//
