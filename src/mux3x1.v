module mux3x1(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire [15:0] c,
	input wire [1:0] sel,
	output wire [15:0] out
);		 

assign out = (sel == 2'b00) ? a :
             (sel == 2'b01) ? b :
             c;	   
			 
endmodule	   

module tb_mux3x1;
    reg [15:0] a, b, c;
    reg [1:0] sel;
    wire [15:0] out;

    mux3x1 uut (
        .a(a),
        .b(b),
        .c(c),
        .sel(sel),
        .out(out)
    );

    initial begin
        $monitor("a=%h, b=%h, c=%h, sel=%b, out=%h", a, b, c, sel, out);
        a = 16'hAAAA; b = 16'h5555; c = 16'hFFFF;
        sel = 2'b00; #10;	  
        sel = 2'b01; #10;												
        sel = 2'b10; #10;												
        $finish;
    end
endmodule
