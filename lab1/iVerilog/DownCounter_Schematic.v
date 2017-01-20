// Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 14.0.0 Build 200 06/17/2014 SJ Web Edition"
// CREATED		"Thu Jan 19 21:22:56 2017"

module DownCounter_Schematic(
	Clk,
	Reset,
	Output
);


input wire	Clk;
input wire	Reset;
output reg	[3:0] Output;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
reg	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_8;
reg	SYNTHESIZED_WIRE_21;
reg	SYNTHESIZED_WIRE_22;
reg	SYNTHESIZED_WIRE_23;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;





always@(posedge Clk or negedge Reset)
begin
if (!Reset)
	begin
	SYNTHESIZED_WIRE_17 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_17 <= SYNTHESIZED_WIRE_0;
	end
end


always@(posedge Clk or negedge Reset)
begin
if (!Reset)
	begin
	SYNTHESIZED_WIRE_23 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_23 <= SYNTHESIZED_WIRE_1;
	end
end

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_17 & SYNTHESIZED_WIRE_2;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4;

assign	SYNTHESIZED_WIRE_3 = SYNTHESIZED_WIRE_18 & SYNTHESIZED_WIRE_19 & SYNTHESIZED_WIRE_20 & SYNTHESIZED_WIRE_8;

assign	SYNTHESIZED_WIRE_12 = SYNTHESIZED_WIRE_21 | SYNTHESIZED_WIRE_22;

assign	SYNTHESIZED_WIRE_13 = SYNTHESIZED_WIRE_18 & SYNTHESIZED_WIRE_19 & SYNTHESIZED_WIRE_20;

assign	SYNTHESIZED_WIRE_14 = SYNTHESIZED_WIRE_23 & SYNTHESIZED_WIRE_12;

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_13 | SYNTHESIZED_WIRE_14;

assign	SYNTHESIZED_WIRE_15 = SYNTHESIZED_WIRE_22 ~^ SYNTHESIZED_WIRE_21;


always@(posedge Clk or negedge Reset)
begin
if (!Reset)
	begin
	SYNTHESIZED_WIRE_21 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_21 <= SYNTHESIZED_WIRE_15;
	end
end


always@(posedge Clk or negedge Reset)
begin
if (!Reset)
	begin
	SYNTHESIZED_WIRE_22 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_22 <= SYNTHESIZED_WIRE_18;
	end
end

assign	SYNTHESIZED_WIRE_18 =  ~SYNTHESIZED_WIRE_22;

assign	SYNTHESIZED_WIRE_20 =  ~SYNTHESIZED_WIRE_23;

assign	SYNTHESIZED_WIRE_19 =  ~SYNTHESIZED_WIRE_21;

assign	SYNTHESIZED_WIRE_8 =  ~SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_21 | SYNTHESIZED_WIRE_23 | SYNTHESIZED_WIRE_22;


endmodule
