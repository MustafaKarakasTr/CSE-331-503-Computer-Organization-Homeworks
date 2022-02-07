// if write_data == 0 and beq or write_data != 0 and bneq, newPc will become imm + noBranchNewPc, otherwise, newPc will become noBranchNewPc
module branchUnit(newPc,noBranchNewPc,write_data,imm,Branch,beqCommand); 
output [31:0] newPc;
input beqCommand;
input [31:0] noBranchNewPc;
input [31:0] write_data;
input[31:0] imm;
input Branch;
wire [31:0] branchNewPc;
wire isZero,notZero,bneqCommand;
wire shouldBranchEq,shouldBranchNeq;
wire branchMustBeTaken;

equal32 eq(isZero,write_data,32'b0);
not nZ(notZero,isZero);
not bneqCommandNot(bneqCommand,beqCommand);
and determineIfBranchEqual(shouldBranchEq,Branch,isZero,beqCommand);
and determineIfBranchNotEqual(shouldBranchNeq,Branch,notZero,bneqCommand);

or deciderIfBranch(branchMustBeTaken,shouldBranchEq,shouldBranchNeq);

adder32bit adder(branchNewPc,noBranchNewPc,imm);
mux2x1_32Bits muxNewPc(newPc,noBranchNewPc,branchNewPc,branchMustBeTaken); // if branchMustBeTaken == 0, newPc will become noBranchNewPc , otherwise newPc will be answer of adder


endmodule