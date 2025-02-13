module I2S(
	input wire m,
	input wire [2:0] rdOld,
	input wire [2:0] rs1Old,
	input wire [4:0] immOld,
	output reg [2:0] rs1,
	output reg [7:0] imm
);

always @* begin
	rs1 <= {m,rdOld[2:1]};
	imm <= {rdOld[0],rs1Old,immOld[4:1]};
end
endmodule	   

module tb_I2S;
    reg m;
    reg [2:0] rdOld, rs1Old;
    reg [4:0] immOld;
    wire [2:0] rs1;
    wire [7:0] imm;

    I2S uut (
        .m(m),
        .rdOld(rdOld),
        .rs1Old(rs1Old),
        .immOld(immOld),
        .rs1(rs1),
        .imm(imm)
    );

    initial begin
        $monitor("m=%b, rdOld=%b, rs1Old=%b, immOld=%b, rs1=%b, imm=%b", m, rdOld, rs1Old, immOld, rs1, imm);
        m = 1; rdOld = 3'b101; rs1Old = 3'b010; immOld = 5'b11001;
        #10 rdOld = 3'b111; rs1Old = 3'b011; immOld = 5'b00110;
        #10 $finish;
    end
endmodule
