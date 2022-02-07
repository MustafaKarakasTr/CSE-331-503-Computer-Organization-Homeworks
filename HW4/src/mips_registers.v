module mips_registers
( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );
	input clk;
	output reg [31:0] read_data_1, read_data_2;
	input [31:0] write_data;
	input [2:0] read_reg_1, read_reg_2, write_reg;
	input signal_reg_write;
	wire[31:0] written_data;
	reg [31:0] registers[7:0] ;
	wire isWriteReg0;
	
	nor checkIfWriteRegIsZero(isWriteReg0,write_reg[2],write_reg[1],write_reg[0]);
	
	mux2x1_32Bits mux(written_data,write_data,32'b0,isWriteReg0); // if register whose value is about to be changed is R0, then do not change it.
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
	if(signal_reg_write)
		registers[write_reg]<=written_data;
	/*if(signal_reg_write)
		$writememb("registers_outp.mem",registers);*/
	
//	registers[read_reg_1]<=32'hFF;
//	registers[read_reg_1]<=32'hA;
	read_data_1 <= registers[read_reg_1];
	read_data_2 <= registers[read_reg_2];
	
	end
	
endmodule