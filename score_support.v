// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Standard Edition"
// CREATED		"Sun Nov 09 17:09:19 2025"

module q6(
	SW,
	HEX0
);


input wire	[3:0] SW;
output wire	[6:0] HEX0;

wire	[6:0] HEX_ALTERA_SYNTHESIZED0;
wire	SYNTHESIZED_WIRE_35;
wire	SYNTHESIZED_WIRE_36;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_37;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_38;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_23;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_27;
wire	SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_33;




assign	SYNTHESIZED_WIRE_35 =  ~SW[3];

assign	SYNTHESIZED_WIRE_33 =  ~SW[2];

assign	SYNTHESIZED_WIRE_30 = SYNTHESIZED_WIRE_35 & SW[2] & SYNTHESIZED_WIRE_36 & SYNTHESIZED_WIRE_2;

assign	SYNTHESIZED_WIRE_6 = SW[2] & SYNTHESIZED_WIRE_36 & SW[0];

assign	SYNTHESIZED_WIRE_5 = SW[1] & SW[2] & SYNTHESIZED_WIRE_4;

assign	SYNTHESIZED_WIRE_4 =  ~SW[0];

assign	HEX_ALTERA_SYNTHESIZED0[1] = SYNTHESIZED_WIRE_5 | SYNTHESIZED_WIRE_6;

assign	SYNTHESIZED_WIRE_7 =  ~SW[2];

assign	SYNTHESIZED_WIRE_8 =  ~SW[0];

assign	HEX_ALTERA_SYNTHESIZED0[2] = SYNTHESIZED_WIRE_7 & SW[1] & SYNTHESIZED_WIRE_8;

assign	SYNTHESIZED_WIRE_9 =  ~SW[2];

assign	SYNTHESIZED_WIRE_37 =  ~SW[1];

assign	SYNTHESIZED_WIRE_36 =  ~SW[1];

assign	SYNTHESIZED_WIRE_12 =  ~SW[0];

assign	SYNTHESIZED_WIRE_28 = SYNTHESIZED_WIRE_9 & SYNTHESIZED_WIRE_37 & SW[0];

assign	SYNTHESIZED_WIRE_26 = SYNTHESIZED_WIRE_37 & SYNTHESIZED_WIRE_12 & SW[2];

assign	SYNTHESIZED_WIRE_13 =  ~SW[1];

assign	SYNTHESIZED_WIRE_29 = SW[2] & SYNTHESIZED_WIRE_13;

assign	SYNTHESIZED_WIRE_14 =  ~SW[3];

assign	SYNTHESIZED_WIRE_38 =  ~SW[2];

assign	SYNTHESIZED_WIRE_20 = SYNTHESIZED_WIRE_14 & SYNTHESIZED_WIRE_38 & SW[0];

assign	SYNTHESIZED_WIRE_17 =  ~SW[0];

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_38 & SW[1] & SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_19 = SW[1] & SW[0];

assign	HEX_ALTERA_SYNTHESIZED0[5] = SYNTHESIZED_WIRE_18 | SYNTHESIZED_WIRE_19 | SYNTHESIZED_WIRE_20;

assign	SYNTHESIZED_WIRE_23 =  ~SW[3];

assign	SYNTHESIZED_WIRE_24 =  ~SW[2];

assign	SYNTHESIZED_WIRE_25 =  ~SW[1];

assign	HEX_ALTERA_SYNTHESIZED0[6] = SYNTHESIZED_WIRE_21 | SYNTHESIZED_WIRE_22;

assign	SYNTHESIZED_WIRE_22 = SYNTHESIZED_WIRE_23 & SYNTHESIZED_WIRE_24 & SYNTHESIZED_WIRE_25;

assign	SYNTHESIZED_WIRE_21 = SW[0] & SW[2] & SW[1];

assign	SYNTHESIZED_WIRE_27 = SW[2] & SW[1] & SW[0];

assign	HEX_ALTERA_SYNTHESIZED0[3] = SYNTHESIZED_WIRE_26 | SYNTHESIZED_WIRE_27 | SYNTHESIZED_WIRE_28;

assign	HEX_ALTERA_SYNTHESIZED0[4] = SW[0] | SYNTHESIZED_WIRE_29;

assign	HEX_ALTERA_SYNTHESIZED0[0] = SYNTHESIZED_WIRE_30 | SYNTHESIZED_WIRE_31;

assign	SYNTHESIZED_WIRE_31 = SYNTHESIZED_WIRE_35 & SYNTHESIZED_WIRE_33 & SYNTHESIZED_WIRE_36 & SW[0];

assign	SYNTHESIZED_WIRE_2 =  ~SW[0];

assign	HEX0 = HEX_ALTERA_SYNTHESIZED0;

endmodule
