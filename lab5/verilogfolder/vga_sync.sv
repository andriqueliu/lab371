/*
This module uses counters to synchronize the vga output data with the screen display

EE371 Lab5
Andrique Liu, Emraj Sidhu, Nikhil Grover
*/

module vga_sync(clk, reset, vga_horiz_sync, vga_vert_sync, display, counterHoriz, counterVert);
	input clk;
	input reset;
	output vga_horiz_sync, vga_vert_sync;
	output display;
	output [9:0] counterHoriz;
	output [9:0] counterVert;

	reg [9:0] counterHoriz;
	reg [9:0] counterVert;
	reg vga_HS, vga_VS; //horizontal and vertical synch signals
	reg display;

	//column counter
	always @(posedge clk) begin
		if(reset)
			counterHoriz <= 0;
		else if(counterHoriz == 10'h320)
			counterHoriz <= 0;
		else
			counterHoriz <= counterHoriz + 1'b1;
	end

	//row counter
	always @(posedge clk) begin
		if(reset)
			counterVert <= 0;
		else if(counterVert == 10'h209)	//521
			counterVert <= 0;
		else if(counterHoriz <= 10'h320)
			counterVert <= counterVert + 1'b1;
	end

	//generate sync signals
	always @(posedge clk) begin
		vga_HS <= (counterHoriz > 655 && counterHoriz < 752);
		vga_VS <= (counterVert == 490 || counterVert == 491);
	end

	always @(posedge clk) begin
		if(reset)
			display <= 0;
		else
			display <= (counterHoriz < 640) && (counterVert < 480);
	end

	assign vga_horiz_sync = ~vga_HS;
	assign vga_vert_sync = ~vga_VS;
	
endmodule