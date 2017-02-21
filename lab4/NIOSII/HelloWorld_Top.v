module HelloWorld_Top(clk, reset, LEDR);

input clk, reset;
output [7:0] LEDR;

proj_qsys test(.clk, .reset, .led_pio_external_connection_export(LEDR));

endmodule
