module I2R(
	input wire m,
	input wire [2:0] rdOld,
	input wire [2:0] rs1Old,
	input wire [4:0] immOld,
	output reg [2:0] rd,
	output reg [2:0] rs1,
	output reg [2:0] rs2
);

always @* begin
	rd <= {m,rdOld[2:1]};
	rs1 <= {rdOld[0],rs1Old[2:1]};
	rs2 <= {rs1Old[0],immOld[4:3]};
end
endmodule			   

module tb_I2R;
    reg m;
    reg [2:0] rdOld, rs1Old;
    reg [4:0] immOld;
    wire [2:0] rd, rs1, rs2;

    I2R uut (
        .m(m),
        .rdOld(rdOld),
        .rs1Old(rs1Old),
        .immOld(immOld),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2)
    );

    initial begin
        $monitor("m=%b, rdOld=%b, rs1Old=%b, immOld=%b, rd=%b, rs1=%b, rs2=%b", m, rdOld, rs1Old, immOld, rd, rs1, rs2);
        m = 1; rdOld = 3'b101; rs1Old = 3'b010; immOld = 5'b11001;
        #10 rdOld = 3'b111; rs1Old = 3'b011; immOld = 5'b00110;
        #10 $finish;
    end
endmodule
