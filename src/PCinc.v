module PCinc(
	input wire [15:0] inputPC,
	output reg [15:0] outPC
);

always @* begin
	outPC = inputPC + 2;
end
endmodule	  

module tb_PCinc;
    reg [15:0] inputPC;
    wire [15:0] outPC;

    PCinc uut (
        .inputPC(inputPC),
        .outPC(outPC)
    );

    initial begin
        $monitor("inputPC=%h, outPC=%h", inputPC, outPC);
        inputPC = 16'h0000;
        #10 inputPC = 16'h0002;
        #10 inputPC = 16'h0004;
        #10 $finish;
    end
endmodule
