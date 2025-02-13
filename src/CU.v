module ControlUnit(
	input wire clk,
	input wire [3:0] opcode,
	input wire m,
	//input wire takeBranch,
	output reg PCen,
	output reg memWrite,
	output reg memRead,
	output reg REGen,
	output reg sign5,
	output reg wrByte,
	output reg signW2B,
	output reg [1:0] RA,
	output reg [1:0] RB,
	output reg [1:0] RW,
	output reg [1:0] PCsrc,
	output reg [1:0] BUSWsrc,
	output reg opAsrc,
	output reg [1:0] opBsrc,
	output reg dataInsrc,
	output reg [4:0] Function, 
	output wire [2:0] R7
);	

assign R7 = 3'b111;

reg [4:0] temp;

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

//stages	
parameter start = 0;
parameter RS = 1;
parameter IF = 2;
parameter ID = 3;
parameter EX = 4;
parameter MEM = 5;
parameter WB = 6; 	
reg [2:0] stage = start;

always @(posedge clk) begin
	case (stage)
		start: begin
			PCen <= 0;
			memWrite <= 0;
			memRead <= 0;
			REGen <= 0;
			stage <= IF;
		end
		
		RS: begin
			PCen <= 1;
			memWrite <= 0;
			memRead <= 0;
			REGen <= 0;
			
			//if (takeBranch == 1): PCsrc <= 2'b01;
			//else: PCsrc <= 2'b00;	 
			
			stage <= IF;
		end	   
		
		IF: begin
			PCen <= 0;
			memWrite <= 0;
			memRead <= 0;
			REGen <= 0;
			stage <= ID;
		end				
		
		ID: begin
			PCen <= 0;	
			PCsrc <= 2'b00;
			memWrite <= 0;
			memRead <= 0;
			REGen <= 0;	
			
			temp = {opcode,1'b0};
			
			if (opcode[3:0] == 4'b0110 || (opcode[3:0] > 4'b0111 && opcode[3:0] < 4'b1100)) begin
				temp[0] = m;
			end
				
			case(temp)
				AND: begin
					REGen <= 0;
					RA <= 2'b00;
					RB <= 2'b00;
					RW <= 2'b00;
					BUSWsrc	<= 2'b00;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end
				
				ADD: begin
					REGen <= 0;
					RA <= 2'b00;
					RB <= 2'b00;
					RW <= 2'b00;
					BUSWsrc	<= 2'b00;
					opAsrc <= 0;
					opBsrc <= 0;
					Function <= temp;
					stage <= EX;
				end	
				
				SUB: begin
					REGen <= 0;
					RA <= 2'b00;
					RB <= 2'b00;
					RW <= 2'b00;
					BUSWsrc	<= 2'b00;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end	
				
				ADDI: begin
					REGen <= 0;
					sign5 <= 1;
					RA <= 2'b01;
					RW <= 2'b01;
					BUSWsrc	<= 2'b00;
					opAsrc <= 0;
					opBsrc <= 2'b01;
					Function <= temp;  
					stage <= EX;
				end
				
				ANDI: begin
					REGen <= 0;
					sign5 <= 1;
					RA <= 2'b01;
					RW <= 2'b01;
					BUSWsrc	<= 2'b00;
					opAsrc <= 0;
					opBsrc <= 2'b01;
					Function <= temp; 
					stage <= EX;
				end
				
				LW: begin
					memRead	<= 0;
					REGen <= 0;
					sign5 <= 1;
					RA <= 2'b01;
					RW <= 2'b01;
					BUSWsrc	<= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b01;
					Function <= temp;
					stage <= EX;
				end	  
				
				LBu: begin
					memRead	<= 0;
					REGen <= 0;
					sign5 <= 1;	
					signW2B <= 0;
					RA <= 2'b01;
					RW <= 2'b01;
					BUSWsrc	<= 2'b10;
					opAsrc <= 0;
					opBsrc <= 2'b01;
					Function <= temp;
					stage <= EX;
				end
				
				LBs: begin
					memRead	<= 0; 
					REGen <= 0;
					sign5 <= 1;	
					signW2B <= 1;
					RA <= 2'b01;
					RW <= 2'b01;
					BUSWsrc	<= 2'b10;
					opAsrc <= 0;
					opBsrc <= 2'b01;
					Function <= temp;
					stage <= EX; 							
				end	  
				
				SW: begin
					memWrite <= 0; 
					wrByte <= 0;
					REGen <= 0;
					sign5 <= 1;
					RA <= 2'b01;   
					RB <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b01;
					dataInsrc <= 0;
					Function <= temp;
					stage <= EX;  
				end
				
				BGT: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end	
				
				BGTZ: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end	
				
				BLT: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end	
				
				BLTZ: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end
				
				BEQ: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end
				
				BEQZ: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end
				
				BNE: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end
				
				BNEZ: begin		
					sign5 <= 1;
					RA <= 2'b01;
					RB <= 2'b01;
					PCsrc <= 2'b01;
					opAsrc <= 0;
					opBsrc <= 2'b00;
					Function <= temp;
					stage <= EX;
				end	 
				
				JMP: begin
					PCsrc <= 2'b10;
					opAsrc <= 1;
					opBsrc <= 2'b10;
					Function <= temp;
					stage <= EX;
				end	
				
				CALL: begin
					REGen <= 0;
					RW <= 2'b10;
					PCsrc <= 2'b10;
					BUSWsrc <= 2'b11;
					opAsrc <= 1;
					opBsrc <= 2'b10;
					Function <= temp;
					stage <= EX;
				end
				
				RET: begin
					RB <= 2'b10;
					PCsrc <= 2'b11;
					Function <= temp;
					stage <= EX;
				end	  
				
				Sv: begin
					memWrite <= 0;
					RA <= 2'b10;
					opAsrc <= 0;
					dataInsrc <= 1;
					Function <= temp;
					stage <= EX; 
				end
			endcase	
		end
		
		EX: begin  
			case (temp)
				AND: begin
					REGen <= 1;
					stage <= WB;
				end
				
				ADD: begin	   
					REGen <= 1;
					stage <= WB;
				end	
				
				SUB: begin		
					REGen <= 1;
					stage <= WB;
				end	
				
				ADDI: begin		
					REGen <= 1;
					stage <= WB;
				end
				
				ANDI: begin	   
					REGen <= 1;
					stage <= WB;
				end
				
				LW: begin	 
					memRead	<= 1;
					REGen <= 1;
					stage <= MEM;
				end	  
				
				LBu: begin	   	 
					memRead	<= 1;
					REGen <= 1;
					stage <= MEM;
				end
				
				LBs: begin	   	 
					memRead	<= 1;
					REGen <= 1;
					stage <= MEM;
				end	  
				
				SW: begin  
					memWrite <= 1;
					stage <= MEM;
				end
				
				BGT: begin		
					stage <= RS;
				end	
				
				BGTZ: begin		
					stage <= RS;					
				end	
				
				BLT: begin		
					stage <= RS;					
				end	
				
				BLTZ: begin		
					stage <= RS;					
				end
				
				BEQ: begin		
					stage <= RS;					
				end
				
				BEQZ: begin		
					stage <= RS;					
				end
				
				BNE: begin		
					stage <= RS;					
				end
				
				BNEZ: begin		
					stage <= RS;					
				end	 
				
				JMP: begin
					stage <= RS;					
				end	
				
				CALL: begin	 
					REGen <= 1;
					stage <= WB;					
				end
				
				RET: begin
					stage <= RS;					
				end	  
				
				Sv: begin  
					memWrite <= 1; 
					wrByte <= 1;
					stage <= MEM;				
				end
			endcase
		end
		
		MEM: begin 
			memWrite <= 0;
			memRead <= 0;
			case (temp)
				LW: begin
					stage <= WB;
				end	  
				
				LBu: begin
					stage <= WB;
				end
				
				LBs: begin
					stage <= WB;
				end	  
				
				SW: begin
					stage <= RS;
				end	
				
				Sv: begin
					stage <= RS;
				end
			endcase
		end
		
		WB: begin 	 
			REGen <= 0;
			stage <= RS;
		end
	endcase
	end
endmodule