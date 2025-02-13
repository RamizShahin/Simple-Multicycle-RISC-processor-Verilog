module extend8(
	input wire [7:0] in,
	output reg [15:0] out
);

always @* begin
		out[15:8] = 8'b0;
		out[7:0] = in[7:0];
end
endmodule		   

module tb_extend8;
    reg [7:0] in;
    wire [15:0] out;

    extend8 uut (
        .in(in),
        .out(out)
    );

    initial begin
        $monitor("in=%b, out=%h", in, out);
        in = 8'b01010101;
        #10 in = 8'b10101010;
        #10 $finish;
    end
endmodule
