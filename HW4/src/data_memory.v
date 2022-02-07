module data_memory
( read_data,write_data, address, mem_write, mem_read,clk );
	output reg [31:0] read_data;
	input clk;
	input [31:0] write_data,address;
	input mem_write,mem_read;
	reg [31:0] memory[255:0];
		
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
	if(mem_write)
		memory[address]<=write_data;
	if(mem_read)
		read_data <= memory[address];

	
	end
	
endmodule