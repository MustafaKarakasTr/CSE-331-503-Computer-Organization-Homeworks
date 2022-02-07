module instruction_memory(instruction,newPc,readAddress,clk);
	output reg [15:0] instruction;
	output reg [31:0] newPc;
	wire [31:0] temp;
	input clk;
	input [31:0] readAddress;
	
	reg [15:0] instructions [36:0];
	adder32bit adder(temp,readAddress,32'b1);
	//this module use behavioral verilog
	//for register & data memory part, use files
	//register.mem or register.txt (file extension is not important)
	
	//--- continuos assignment --- 
	//output data;
	//assign data = registers[adress];
	//--- non-blocking assignment ---
	//register data;
	//data <= registers[write_reg];
	always @(posedge clk) 
	begin
	instruction <= instructions[readAddress];
	newPc <=temp;
	end
	

endmodule