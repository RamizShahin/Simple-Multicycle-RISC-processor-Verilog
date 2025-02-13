module alu(
	input wire [15:0] operandA,
	input wire [15:0] operandB,   
	input wire [4:0] Function,
	output reg [15:0] res,
	output reg takeBranch
);		

reg [15:0] temp;

//R type
parameter AND = 5'b00000;
parameter ADD = 5'b00010;
parameter SUB = 5'b00100;

//I type
parameter ADDI = 5'b00110;
parameter ANDI = 5'b01000;
parameter LW = 5'b01010;
parameter LBu = 5'b01100;
parameter LBs = 5'b01101;
parameter SW = 5'b01110;

//branch
parameter BGT = 5'b10000;
parameter BGTZ = 5'b10001;
parameter BLT = 5'b10010;
parameter BLTZ = 5'b10011;
parameter BEQ = 5'b10100;
parameter BEQZ = 5'b10101;
parameter BNE = 5'b10110;
parameter BNEZ = 5'b10111;

//J type
parameter JMP = 5'b11000;
parameter CALL = 5'b11010;
parameter RET = 5'b11100;

//S type
parameter Sv = 5'b11110;	  

always @* begin	 
	res = 16'b0;
	takeBranch = 1'b0;
	
	case(Function)
		AND: res = operandA & operandB;
		ADD: res = operandA + operandB;
		SUB: res = operandA - operandB;
		
		ADDI: res = operandA + operandB;
		ANDI: res = operandA & operandB;
		LW: res = operandA + operandB;
		LBu: res = operandA + operandB;
		LBs: res = operandA + operandB;
		SW: res = operandA + operandB;
		
		BGT: takeBranch = (operandB > operandA) ? 1 : 0;
		BGTZ: takeBranch = (operandB > 0) ? 1 : 0;
		BLT: takeBranch = (operandB < operandA) ? 1 : 0;
		BLTZ: takeBranch = (operandB < 0) ? 1 : 0;
		BEQ: takeBranch = (operandB == operandA) ? 1 : 0;
		BEQZ: takeBranch = (operandB == 0) ? 1 : 0;
		BNE: takeBranch = (operandB == operandA) ? 0 : 1;
		BNEZ: takeBranch = (operandB == 0) ? 0 : 1;   
		
		JMP: begin										  
			temp = operandB << 1;
			res = {operandA[15:12],temp[11:0]};
		end
		
		CALL: begin										  
			temp = operandB << 1;
			res = {operandA[15:12],temp[11:0]};
		end
		
		RET: res = operandB;
		
		Sv: res = operandA;		
	endcase
end
endmodule	

module tb_alu;
    reg [15:0] operandA, operandB;
    reg [4:0] Function;
    wire [15:0] res;
    wire zeroFlag, negativeFlag;

    alu uut (
        .operandA(operandA),
        .operandB(operandB),
        .Function(Function),
        .res(res),
        .takeBranch(takeBranch)
    );

    initial begin
        $monitor("operandA=%h, operandB=%h, Function=%b, res=%h, takeBranch=%b", operandA, operandB, Function, res, takeBranch);
        operandA = 16'h0001; operandB = 16'h0001; Function = 5'b00010; // ADD
        #10 Function = 5'b00100; // SUB
        #10 Function = 5'b00000; // AND
        #10 Function = 5'b10100; // BEQ
        #10 $finish;
    end
endmodule
