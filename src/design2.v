											//-----------------------------------------------------------------------------
//
// Title       : 
// Design      : cpu
// Author      : 
// Company     : 
//
//-----------------------------------------------------------------------------
//
// File        : C:\Users\ramiz\Desktop\architecture2\cpu\compile\design2.v
// Generated   : Tue Jun  4 00:23:38 2024
// From        : C:\Users\ramiz\Desktop\architecture2\cpu\src\design2.bde
// By          : Bde2Verilog ver. 2.01
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`ifdef _VCP
`else
`define library(a,b)
`endif


// ---------- Design Unit Header ---------- //
`timescale 1ps / 1ps

module design2 (clk) ;

// ------------ Port declarations --------- //
input clk;
wire clk;

// ----------- Signal declarations -------- //
wire NET1009;
wire NET1015;
wire NET1027;
wire NET1033;
wire NET1038;
wire NET1044;
wire NET1057;
wire NET1067;
wire NET1074;
wire NET1658;
wire NET976;
wire [1:0] BUS1004;
wire [1:0] BUS1020;
wire [4:0] BUS1052;
wire [1:0] BUS1062;
wire [1:0] BUS1078;
wire [2:0] BUS1091;
wire [1:0] BUS1098;
wire [1:0] BUS1624;
wire [15:0] BUS672;
wire [2:0] BUS682;
wire [2:0] BUS700;
wire [2:0] BUS713;
wire [4:0] BUS724;
wire [2:0] BUS742;
wire [2:0] BUS746;
wire [2:0] BUS750;
wire [2:0] BUS754;
wire [7:0] BUS775;
wire [15:0] BUS788;
wire [15:0] BUS796;
wire [15:0] BUS808;
wire [2:0] BUS832;
wire [2:0] BUS836;
wire [15:0] BUS847;
wire [15:0] BUS851;
wire [15:0] BUS857;
wire [15:0] BUS868;
wire [15:0] BUS878;
wire [15:0] BUS890;
wire [15:0] BUS895;
wire [15:0] BUS905;
wire [15:0] BUS917;
wire [15:0] BUS928;
wire [11:0] BUS930;
wire [15:0] BUS936;
wire [15:0] BUS940;
wire [15:0] BUS942;
wire [3:0] BUS958;
wire [15:0] BUS972;

// -------- Component instantiations -------//

PCreg U1
(
	.clk(clk),
	.en(NET1009),
	.in(BUS788),
	.out(BUS796)
);



mux3_3x1 U10
(
	.in1(BUS750),
	.in2(BUS713),
	.in3(BUS754),
	.sel(BUS1624),
	.out(BUS746)
);



PCinc U11
(
	.inputPC(BUS796),
	.outPC(BUS857)
);



extend8 U12
(
	.in(BUS775),
	.sign(NET1033),
	.out(BUS928)
);



extend5 U13
(
	.in(BUS724),
	.sign(NET1015),
	.out(BUS808)
);



mux4x1 U14
(
	.a(BUS857),
	.b(BUS851),
	.c(BUS878),
	.d(BUS868),
	.sel(BUS1004),
	.out(BUS788)
);



adder U15
(
	.in1(BUS808),
	.in2(BUS796),
	.out(BUS972)
);



datamem U16
(
	.clk(clk),
	.address(BUS878),
	.datain(BUS847),
	.memread(NET1038),
	.memwrite(NET1044),
	.dataout(BUS890)
);



mux3_3x1 U17
(
	.in1(BUS832),
	.in2(BUS700),
	.in3(BUS1091),
	.sel(BUS1098),
	.out(BUS836)
);



mux2x1 U18
(
	.a(BUS868),
	.b(BUS928),
	.sel(NET1067),
	.out(BUS847)
);



W2B U19
(
	.in(BUS890),
	.sign(NET1057),
	.out(BUS905)
);



instmem U2
(
	.inputPC(BUS796),
	.instruction(BUS672)
);



mux3x1 U20
(
	.a(BUS868),
	.b(BUS808),
	.c(BUS936),
	.sel(BUS1078),
	.out(BUS917)
);



mux2x1 U21
(
	.a(BUS940),
	.b(BUS796),
	.sel(NET1074),
	.out(BUS942)
);



mux4x1 U22
(
	.a(BUS878),
	.b(BUS890),
	.c(BUS905),
	.d(BUS857),
	.sel(BUS1062),
	.out(BUS895)
);



extend12 U23
(
	.in(BUS930),
	.out(BUS936)
);



mux2x1 U24
(
	.a(BUS857),
	.b(BUS972),
	.sel(NET976),
	.out(BUS851)
);



// synthesis translate_off
`library("U25","cpu")
// synthesis translate_on
ControlUnit U25
(
	.clk(clk),
	.opcode(BUS958),
	.m(NET1658),
	.PCen(NET1009),
	.memWrite(NET1044),
	.memRead(NET1038),
	.REGen(NET1027),
	.sign5(NET1015),
	.sign8(NET1033),
	.signW2B(NET1057),
	.RA(BUS1624),
	.RB(BUS1098),
	.RW(BUS1020),
	.PCsrc(BUS1004),
	.BUSWsrc(BUS1062),
	.opAsrc(NET1074),
	.opBsrc(BUS1078),
	.dataInsrc(NET1067),
	.Function(BUS1052),
	.R7(BUS1091)
);



IR U3
(
	.instruction(BUS672),
	.opcode(BUS958),
	.m(NET1658),
	.rd(BUS700),
	.rs1(BUS713),
	.imm(BUS724)
);



I2R U4
(
	.m(NET1658),
	.rdOld(BUS700),
	.rs1Old(BUS713),
	.immOld(BUS724),
	.rd(BUS742),
	.rs1(BUS750),
	.rs2(BUS832)
);



I2J U5
(
	.m(NET1658),
	.rdOld(BUS700),
	.rs1Old(BUS713),
	.immOld(BUS724),
	.offset(BUS930)
);



I2S U6
(
	.m(NET1658),
	.rdOld(BUS700),
	.rs1Old(BUS713),
	.immOld(BUS724),
	.rs1(BUS754),
	.imm(BUS775)
);



alu U7
(
	.operandA(BUS942),
	.operandB(BUS917),
	.Function(BUS1052),
	.res(BUS878),
	.takeBranch(NET976)
);



registers U8
(
	.clk(clk),
	.en(NET1027),
	.RA(BUS746),
	.RB(BUS836),
	.RW(BUS682),
	.BUSW(BUS895),
	.BUSA(BUS940),
	.BUSB(BUS868)
);



mux3_3x1 U9
(
	.in1(BUS742),
	.in2(BUS700),
	.in3(BUS1091),
	.sel(BUS1020),
	.out(BUS682)
);



endmodule 
