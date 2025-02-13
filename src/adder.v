module adder(
	input wire [15:0] in1,
	input wire [15:0] in2,
	output reg [15:0] out
);	   

reg [15:0] temp;

always @* begin	 					
	temp = {in1[15],in1[13:0],1'b0};
	out = temp + in2;
end
endmodule			

module tb_adder;
    reg [15:0] in1, in2;
    wire [15:0] out;

    adder uut (
        .in1(in1),
        .in2(in2),
        .out(out)
    );

    initial begin
        $monitor("in1=%h, in2=%h, out=%h", in1, in2, out);
        in1 = 16'h0001; in2 = 16'h0001;
        #10 in1 = 16'hAAAA; in2 = 16'h5555;	 
		#10 in1 = 16'hFFFF; in2 = 16'hFFFF;
        #10 $finish;
    end
endmodule
