module registers(
	input clk,
	input wire en,
	input wire [2:0] RA,
	input wire [2:0] RB,
	input wire [2:0] RW,
	input wire [15:0] BUSW,
	output reg [15:0] BUSA,
	output reg [15:0] BUSB
);				

reg [15:0] register [7:0];	
integer i;

initial begin
	for (i = 0; i < 8; i = i + 1) begin
		register[i] = 16'd0;
	end
end

always @(posedge clk) begin
	if (en && (RW != 3'b000)) begin
		register[RW] <= BUSW;
	end		   			   
	
	BUSA <= register[RA];
	BUSB <= register[RB];
end
endmodule		

module tb_registers;
    reg clk, en;
    reg [2:0] RA, RB, RW;
    reg [15:0] BUSW;
    wire [15:0] BUSA, BUSB;	 

    registers uut (
        .clk(clk),
        .en(en),
        .RA(RA),
        .RB(RB),
        .RW(RW),
        .BUSW(BUSW),
        .BUSA(BUSA),
        .BUSB(BUSB)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("clk=%b, en=%b, RA=%b, RB=%b, RW=%b, BUSW=%h, BUSA=%h, BUSB=%h, reg[RA]=%h, reg[RB]=%h, reg[RW]=%h", clk, en, RA, RB, RW, BUSW, BUSA, BUSB, uut.register[RA], uut.register[RB], uut.register[RW]);
        en = 1; RW = 3'b000; BUSW = 16'hAAAA;
        #10 RA = 3'b001; RB = 3'b000;
        #10 RW = 3'b010; BUSW = 16'h5555;
        #10 RA = 3'b010; RB = 3'b001;
        #10 $finish;
    end
endmodule
