module mux3_2x1(
	input wire [2:0] in1,
	input wire [2:0] in2, 
	input wire sel,
	output wire [2:0] out
);

assign out = (sel == 0) ? in1 : in2;
endmodule				

module tb_mux3_2x1;
    reg [2:0] in1, in2;
    reg sel;
    wire [2:0] out;

    mux3_2x1 uut (
        .in1(in1),
        .in2(in2),
        .sel(sel),
        .out(out)
    );

    initial begin
        $monitor("in1=%b, in2=%b, sel=%b, out=%b", in1, in2, sel, out);
        in1 = 3'b101; in2 = 3'b010; sel = 0;
        #10 sel = 1;
        #10 $finish;
    end
endmodule
