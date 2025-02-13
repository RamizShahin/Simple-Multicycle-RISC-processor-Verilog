module instmem(
	input wire [15:0] inputPC,
	output reg [15:0] instruction
);

reg [7:0] mem[31:0];

parameter AND = 4'b0000;
parameter ADD = 4'b0001;
parameter SUB = 4'b0010;

//I type
parameter ADDI = 4'b0011;
parameter ANDI = 4'b0100;
parameter LW = 4'b0101;
parameter LBu = 4'b0110;
parameter LBs = 4'b0110;
parameter SW = 4'b0111;

//branch
parameter BGT = 4'b1000;
parameter BGTZ = 4'b1000;
parameter BLT = 4'b1001;
parameter BLTZ = 4'b1001;
parameter BEQ = 4'b1010;
parameter BEQZ = 4'b1010;
parameter BNE = 4'b1011;
parameter BNEZ = 4'b1011;

//J type
parameter JMP = 4'b1100;
parameter CALL = 4'b1101;
parameter RET = 4'b1110;

//S type
parameter Sv = 4'b1111;

initial begin
  // initialize the memory with the program
  
  // mem[0] = ADDI R0, R0, -1; R0 = 0 since it cannot be modified
  mem[0] = {3'b000, 5'b11111};
  mem[1] = {ADDI, 1'b0, 3'b000};
  
  // mem[2] = Sv R0, 16; mem[0] = 8'hFF
  mem[2] = {7'b1111111, 1'b0};  
  mem[3] = {Sv, 3'b000, 1'b1};
  
  // mem[4] = BGTZ R1, 5; PC = PC + 3 = 5 x 2 = 10
  mem[4] = {3'b000, 5'b00011};
  mem[5] = {BGTZ, 1'b1, 3'b001};
  
  // mem[6] = ADDI R1, R0, 1; R1 = 0 + 1 = 1
  mem[6] = {3'b000, 5'b00001};
  mem[7] = {ADDI, 1'b0, 3'b001};
  
  // mem[8] = JMP 2
  mem[8] = {8'b0000_0010};
  mem[9] = {JMP, 4'b0000};
  
  // mem[10] = LW R2, R0, 0; R2 = mem[0] = 16'h00FF
  mem[10] = {3'b000, 5'b00000};
  mem[11] = {LW, 1'b0, 3'b010};
  
  // mem[12] = LBu R3, R0, 0; R3 = mem[0] = 16'h00FF
  mem[12] = {3'b000, 5'b00000};
  mem[13] = {LBu, 1'b0, 3'b011};
  
  // mem[14] = LBs R4, R0, 0; R4 = mem[0] = 16'hFFFF
  mem[14] = {3'b000, 5'b00000};
  mem[15] = {LBs, 1'b1, 3'b100};
  
  // mem[16] = AND R2, R2, R3; R2 = R2 & R3 = 16'h00FF
  mem[16] = {2'b10, 3'b011, 3'b000};
  mem[17] = {AND, 3'b010, 1'b0};
  
  // mem[18] = SW R2, R1, 1; mem[2] = 16'h00FF
  mem[18] = {3'b001, 5'b00001};
  mem[19] = {SW, 1'b0, 3'b010};
  
  // mem[20] = CALL 13
  mem[20] = {8'b0000_1101};
  mem[21] = {CALL, 4'b0000};
  
  // mem[22] = SUB R1, R1, R1; R1 = 1 - 1 = 0
  mem[22] = {2'b01, 3'b001, 3'b000};
  mem[23] = {SUB, 3'b001, 1'b0};
  
  // mem[24] = JMP 14
  mem[24] = {8'b0000_1110};  
  mem[25] = {JMP, 4'b0000};
  
  // mem[26] = RET; back to mem[11]
  mem[26] = {8'b0000_0000};
  mem[27] = {RET, 4'b0000};
  
  // mem[28] = ADDI R1, R1, -1; R1 = 0 - 1 = 16'hFFFF
  mem[28] = {3'b001, 5'b11111};
  mem[29] = {ADDI, 1'b0, 3'b001};
  
end


always @* begin
	instruction[15:8] <= mem[inputPC[15:0] + 1];
	instruction[7:0] <= mem[inputPC[15:0]];
end
endmodule			 

module tb_instmem;
    reg [15:0] inputPC;
    wire [15:0] instruction;

    instmem uut (
        .inputPC(inputPC),
        .instruction(instruction)
    );

    initial begin
        $monitor("inputPC=%h, instruction=%h", inputPC, instruction);
        inputPC = 16'h0000;
        #10 inputPC = 16'h0002;
        #10 inputPC = 16'h0004;
        #10 $finish;
    end
endmodule
