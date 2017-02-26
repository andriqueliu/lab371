module lab4top (CLOCK_50, KEY, LEDR);
	input  CLOCK_50;
	input  [3:0] KEY;
	output [7:0] LEDR;
	
	lab4 nios (.clk_clk(CLOCK_50), .led_pio_external_connection_export(LEDR), .reset_reset_n(KEY[0]));
endmodule
