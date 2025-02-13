module mux3_3x1(
	input wire [2:0] in1,
	input wire [2:0] in2,
	input wire [2:0] in3,
	input wire [1:0] sel,
	output wire [2:0] out
);

assign out = (sel == 0) ? in1 : (sel == 1) ? in2 : in3;
endmodule	