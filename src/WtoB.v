module W2B(
	input wire [15:0] in,
	input wire sign,
	output reg [15:0] out
);

always @* begin
	if (sign) begin
		out[7:0] = in[7:0];
		out[15:8] = {8{in[7]}};
	end
	else begin
		out[15:8] = 8'b0;
		out[7:0] = in[7:0];
	end		
end
endmodule