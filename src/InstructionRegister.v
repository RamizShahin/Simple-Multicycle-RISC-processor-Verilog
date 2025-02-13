module IR(
	input wire [15:0] instruction, 
	output reg [3:0] opcode,
	output reg m,
	output reg [2:0] rd,
	output reg [2:0] rs1,
	output reg [4:0] imm
);

always @* begin
	opcode <= instruction[15:12];
	m <= instruction[11];
	rd <= instruction[10:8];
	rs1 <= instruction[7:5];
	imm <= instruction[4:0];
end
endmodule			

module tb_IR;
    reg [15:0] instruction;
    wire [3:0] opcode;
    wire m;
    wire [2:0] rd, rs1;
    wire [4:0] imm;

    IR uut (
        .instruction(instruction),
        .opcode(opcode),
        .m(m),
        .rd(rd),
        .rs1(rs1),
        .imm(imm)
    );

    initial begin
        $monitor("instruction=%h, opcode=%b, m=%b, rd=%b, rs1=%b, imm=%b", instruction, opcode, m, rd, rs1, imm);
        instruction = 16'hF123;
        #10 instruction = 16'hA456;
        #10 $finish;
    end
endmodule
