module PCreg(
	input clk,	
	input wire en,
	input wire [15:0] in,
	output reg [15:0] out
);

reg [15:0] register;

initial begin
	register = 16'b0; 
	out = register;
end		  

always @(posedge clk) begin
	if (en) begin
		register = in;
	end	  
end		  

always @* begin
	out = register; 
end
endmodule		  

module tb_PCre;
    reg clk, en;
    reg [15:0] in;
    wire [15:0] out;

    PCreg uut (
        .clk(clk),
        .en(en),
        .in(in),
        .out(out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("clk=%b, en=%b, in=%h, out=%h", clk, en, in, out);
        en = 1; in = 16'h0001;
        #10 in = 16'h0002;
        #10 en = 0; in = 16'h0003;
        #10 en = 1; in = 16'h0004;
        #10 $finish;
    end
endmodule
