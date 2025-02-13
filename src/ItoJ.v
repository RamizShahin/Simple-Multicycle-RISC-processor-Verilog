module I2J(
	input wire m,
	input wire [2:0] rdOld,
	input wire [2:0] rs1Old,
	input wire [4:0] immOld,   
	output reg [11:0] offset
);

always @* begin
	offset <= {m,rdOld,rs1Old,immOld};
end
endmodule			   

module tb_I2J;
    reg m;
    reg [2:0] rdOld, rs1Old;
    reg [4:0] immOld;
    wire [11:0] offset;

    I2J uut (
        .m(m),
        .rdOld(rdOld),
        .rs1Old(rs1Old),
        .immOld(immOld),
        .offset(offset)
    );

    initial begin
        $monitor("m=%b, rdOld=%b, rs1Old=%b, immOld=%b, offset=%b", m, rdOld, rs1Old, immOld, offset);
        m = 1; rdOld = 3'b101; rs1Old = 3'b010; immOld = 5'b11001;
        #10 rdOld = 3'b111; rs1Old = 3'b011; immOld = 5'b00110;
        #10 $finish;
    end
endmodule
