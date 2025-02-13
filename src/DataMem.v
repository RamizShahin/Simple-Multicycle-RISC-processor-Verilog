module datamem(				  
	input wire clk,
	input wire [15:0] address,
	input wire [15:0] datain,
	input wire memread,
	input wire memwrite, 
	input wire wrByte,
	output reg [15:0] dataout
);			  

reg [7:0] mem[31:0];  

initial begin
	for (int i = 0; i < 32; i = i + 1) begin
		mem[i] = 8'd0;
	end
end

always @(posedge clk) begin
	if (memwrite) begin
		if (wrByte) begin
			mem[address] <= datain[7:0];
		end
		else begin
			mem[address] <= datain[7:0];
			mem[address + 1] <= datain[15:8];
		end
		
	end
end	   

always @* begin
	if (memread) begin
		dataout <= {mem[address + 1], mem[address]};
	end
end
endmodule			 

module tb_datamem;
  
  // inputs
  reg clk;
  reg [15:0] address;
  reg [15:0] datain;
  reg memread;
  reg memwrite;
  reg wrByte;

  // outputs
  wire [15:0] dataout;

  // instantiate the unit under test (uut)
  datamem uut (
    .clk(clk),
    .address(address),
    .datain(datain),
    .memread(memread),
    .memwrite(memwrite),
    .wrByte(wrByte),
    .dataout(dataout)
  );

  // clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // stimulus
  initial begin
    // initialize inputs
    address = 0;
    datain = 0;
    memread = 0;
    memwrite = 0;
    wrByte = 0;

    // wait for global reset
    #10;

    // test case 1: write a word (16-bit) to address 0
    address = 16'h0000;
    datain = 16'hABCD;
    memwrite = 1;
    wrByte = 0;
    #10;
    memwrite = 0;

    // test case 2: read the word back from address 0
    address = 16'h0000;
    memread = 1;
    #10;
    memread = 0;
    #10;

    // test case 3: write a byte (8-bit) to address 1
    address = 16'h0001;
    datain = 16'h00EF;
    memwrite = 1;
    wrByte = 1;
    #10;
    memwrite = 0;

    // test case 4: read the word back from address 0 to check byte overwrite
    address = 16'h0000;
    memread = 1;
    #10;
    memread = 0;
    #10;

    // test case 5: write a word (16-bit) to address 2
    address = 16'h0002;
    datain = 16'h1234;
    memwrite = 1;
    wrByte = 0;
    #10;
    memwrite = 0;

    // test case 6: read the word back from address 2
    address = 16'h0002;
    memread = 1;
    #10;
    memread = 0;
    #10;

    // end of test
    $finish;
  end

endmodule

