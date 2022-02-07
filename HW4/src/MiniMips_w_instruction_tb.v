`define DELAY 10
module MiniMips_w_instruction_tb();
reg clk;
reg [31:0] pc;
wire [31:0] newPc;
MiniMips_w_instruction uut(pc,clk, newPc);
 initial
	begin
		clk = 1'b0;
		pc <= 0;
	end
always
	begin
		#1 clk = ~clk;
	end
always 
	begin
		#`DELAY;
		if(pc>32)
		begin
			$writememb("registers_outp.mem", uut.mipsregisters.registers);
			$writememb("data_memory_outp.mem", uut.DataMemory.memory);
			$stop;
		end	
		else
			begin
				pc<=newPc;
				$writememb("registers_outp.mem", uut.mipsregisters.registers);
				$writememb("data_memory_outp.mem", uut.DataMemory.memory);
				// to be able to see result of instructions one by one, stop command must be activated
				//$stop;
			end
	end
initial begin
$readmemb("registers.mem", uut.mipsregisters.registers);
$readmemb("data.txt", uut.DataMemory.memory);
$readmemb("instructions.txt", uut.instructionMemory.instructions);
end

initial
begin
$monitor("time : %1d,instruction: %1b, address = %1d,newPc=%1d write_reg = %1d ,write_data_register = %1b,MemtoReg = %1b,registers[%1d]=%1d,memory address = %1d,memory[%1d],= %1b",$time,uut.instruction,pc,newPc,uut.write_reg,uut.write_data_register,uut.MemtoReg,uut.write_reg,uut.mipsregisters.registers[uut.write_reg],uut.write_data,uut.write_data,uut.DataMemory.memory[uut.write_data]);
end  

endmodule