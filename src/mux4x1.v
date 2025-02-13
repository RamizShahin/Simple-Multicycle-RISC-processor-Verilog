module mux4x1(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire [15:0] c,
	input wire [15:0] d,
	input wire [1:0] sel,
	output wire [15:0] out
);		 

assign out = (sel == 2'b00) ? a :
             (sel == 2'b01) ? b :
             (sel == 2'b10) ? c :
			 d;
endmodule			   

module tb_mux4x1;
    reg [15:0] a, b, c, d;
    reg [1:0] sel;
    wire [15:0] out;

    mux4x1 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)
    );

    initial begin
        $monitor("a=%h, b=%h, c=%h, d=%h, sel=%b, out=%h", a, b, c, d, sel, out);
        a = 16'hAAAA; b = 16'h5555; c = 16'hFFFF; d = 16'h0000;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        $finish;
    end
endmodule
