
module nios_system (
	clk_clk,
	reset_reset_n,
	switches_export,
	gpio_0_out_export,
	gpio_0_in_export);	

	input		clk_clk;
	input		reset_reset_n;
	input	[1:0]	switches_export;
	output	[1:0]	gpio_0_out_export;
	input		gpio_0_in_export;
endmodule
