module lab4top (clk, leds, reset);
	input clk, reset;
	output [7:0] leds;
	
	lab4 nios (.clk_clk(clk), .led_pio_external_connection_export(leds), .reset_reset_n(reset));
endmodule
