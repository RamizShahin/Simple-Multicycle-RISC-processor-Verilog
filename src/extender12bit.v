module extend12(
	input wire [11:0] in,
	output reg [15:0] out
);

always @* begin
	out[15:12] = 4'b0;
	out[11:0] = in[11:0];
end
endmodule