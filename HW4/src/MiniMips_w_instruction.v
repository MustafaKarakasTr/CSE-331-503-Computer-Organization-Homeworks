module MiniMips_w_instruction(pc,clk,newPc);
input clk;
input [31:0] pc;
output [31:0] newPc;
wire [15:0] instruction;
wire [31:0] newPc;
wire [31:0] branchNewPc;
wire [31:0] noBranchNewPc;
wire[2:0] ALUCtrl;
wire [31:0] a,b,answer;
wire [31:0] readedFromDataMemory;
wire RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch;

//--------------
   wire [31:0] read_data_1, read_data_2;
	wire [31:0] write_data;
	wire [2:0] read_reg_1, read_reg_2, write_reg,write_regRegDst1;
	wire [5:0] imm;
	wire[31:0] imm32Bit,write_data_register;
	wire[31:0] aluInput2; // mux will select between imm32Bit and ReadData2
	//---------------
//this module is a top-level entity
//all modules in this project that have to use just structural verilog (except register & data modules)
//MiniMIPS has to work correctly for 15 instruction.
//alu32 design has to stay same with assignment3
//write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write,
/*and a1(read_reg_1[0],1'b1,1'b1);//read_reg_1 = rs,read_reg_2 = rt R type 
and a11(read_reg_1[1],1'b1,1'b0);
and a111(read_reg_1[2],1'b1,1'b0);
*/

instruction_memory instructionMemory(instruction,noBranchNewPc,pc,clk);
and takeImm1(imm[0],1'b1,instruction[0]);
and takeImm2(imm[1],1'b1,instruction[1]);
and takeImm3(imm[2],1'b1,instruction[2]);
and takeImm4(imm[3],1'b1,instruction[3]);
and takeImm5(imm[4],1'b1,instruction[4]);
and takeImm6(imm[5],1'b1,instruction[5]);
extendImm extend(imm32Bit,imm);
// if write_data == 0 and beq or write_data != 0 and bneq, newPc will become imm + noBranchNewPc, otherwise, newPc will become noBranchNewPc
branchUnit branchUnitModule(newPc,noBranchNewPc,write_data,imm32Bit,Branch,instruction[12]); // instruction[12] holds the last element of opcode, if it is branch opcode and the opcode[0] is 1 than it is beq 
//or32 orOp(newPc,noBranchNewPc,32'b0);

and a1(read_reg_1[2],1'b1,instruction[11]);//read_reg_1 = rs,read_reg_2 = rt write_reg = rd => R type 
and a11(read_reg_1[1],1'b1,instruction[10]);
and a111(read_reg_1[0],1'b1,instruction[9]);

and a2(read_reg_2[2],1'b1,instruction[8]);
and a22(read_reg_2[1],1'b1,instruction[7]);
and a222(read_reg_2[0],1'b1,instruction[6]);

and writeRegSelector(write_regRegDst1[2],1'b1,instruction[5]);
and writeRegSelector2(write_regRegDst1[1],1'b1,instruction[4]);
and writeRegSelector3(write_regRegDst1[0],1'b1,instruction[3]);



/*
and takeImm7(imm[6],1'b1,instruction[6]);
and takeImm8(imm[7],1'b1,instruction[7]);
and takeImm9(imm[8],1'b1,instruction[8]);
and takeImmA(imm[9],1'b1,instruction[9]);
*/
//extend immidiate

wire [3:0] operationCode;
wire[2:0] funcCode;
and t1(operationCode[3],1'b1,instruction[15]);
and t2(operationCode[2],1'b1,instruction[14]);
and t3(operationCode[1],1'b1,instruction[13]);
and t4(operationCode[0],1'b1,instruction[12]);

and t5(funcCode[2],1'b1,instruction[2]);
and t6(funcCode[1],1'b1,instruction[1]);
and t7(funcCode[0],1'b1,instruction[0]);
// mainControl(RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch,ALUctrl,opCode,func);

mainControl mainC (
RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch,
 ALUCtrl,
 operationCode,
 funcCode
);
//mux2x1ThreeBits mux(write_reg,read_reg2,write_regRegDst1,RegDst);
mux2x1ThreeBits muxRegDst(write_reg,read_reg_2,write_regRegDst1,RegDst);
//Verilog coding guidelines 
//Guideline #1: When modeling sequential logic, use nonblocking assignments.
//Guideline #2: When modeling latches, use nonblocking assignments.
//Guideline #3: When modeling combinational logic with an always block, use blocking assignments.
mips_registers mipsregisters(read_data_1, read_data_2, write_data_register, read_reg_1, read_reg_2, write_reg, RegWrt, clk );

mux2x1_32Bits muxAluInputSelector(aluInput2,read_data_2,imm32Bit,ALUSrc); // mux will select between imm32Bit and ReadData2)
/*
	output [31:0] read_data_1, read_data_2;
	input [31:0] write_data;
	input [2:0] read_reg_1, read_reg_2, write_reg;
	input signal_reg_write, clk;
	
	reg [7:0] registers [31:0];
		
*/

and32 and32Bit(a,32'hFFFF_0000,32'hFFFF_0000);
and32 and32Bit2(b,32'h0000_FFFF,32'h0000_FFFF);
 
/*alu32 alu32 (
answer,a, b,ALUCtrl
);*/
alu32 alu32 (
write_data,read_data_1, aluInput2,ALUCtrl
);
//( read_data,write_data, address, mem_write, mem_read,clk );
//( read_data,write_data, address, mem_write, mem_read,clk )
data_memory DataMemory( readedFromDataMemory,read_data_2, write_data, MemWrite, MemRead,clk );
mux2x1_32Bits muxRegisterWriteDataSelector(write_data_register,write_data,readedFromDataMemory,MemtoReg);
endmodule