module extend5(
	input wire [4:0] in,
	input wire sign,
	output reg [15:0] out
);

always @* begin
	if (sign) begin
		out[4:0] = in[4:0];
		out[15:5] = {11{in[4]}};
	end
	else begin
		out[15:5] = 11'b0;
		out[4:0] = in[4:0];
	end
end
endmodule	   

module tb_extend5;
    reg [4:0] in;
    reg sign;
    wire [15:0] out;

    extend5 uut (
        .in(in),
        .sign(sign),
        .out(out)
    );

    initial begin
        $monitor("in=%b, sign=%b, out=%h", in, sign, out);
        in = 5'b01010; sign = 0;
        #10 sign = 1;
        #10 in = 5'b10101;
        #10 $finish;
    end
endmodule
