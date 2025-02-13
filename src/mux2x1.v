module mux2x1(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire sel,
	output wire [15:0] out
);		 

assign out = (sel == 1'b0) ? a : b;	   
			 
endmodule				 

module tb_mux2x1;
    reg [15:0] a, b;
    reg sel;
    wire [15:0] out;

    mux2x1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        $monitor("a=%h, b=%h, sel=%b, out=%h", a, b, sel, out);
        a = 16'hAAAA; b = 16'h5555; sel = 0;
        #10 sel = 1;	
        #10 $finish;
    end
endmodule
