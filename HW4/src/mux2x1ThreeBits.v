module mux2x1ThreeBits(write_reg,read_reg_2,write_regRegDst1,RegDst);
output[2:0] write_reg;
input[2:0] read_reg_2,write_regRegDst1;
input wire RegDst;
wire notRegDst;

not reverseRegDst(notRegDst,RegDst);

wire [2:0] ans1,ans2;

and and1(ans1[0],read_reg_2[0],notRegDst);
and and2(ans1[1],read_reg_2[1],notRegDst);
and and3(ans1[2],read_reg_2[2],notRegDst);

and and4(ans2[0],write_regRegDst1[0],RegDst);
and and5(ans2[1],write_regRegDst1[1],RegDst);
and and6(ans2[2],write_regRegDst1[2],RegDst);

or findWriteReg(write_reg[0],ans1[0],ans2[0]);
or findWriteReg2(write_reg[1],ans1[1],ans2[1]);
or findWriteReg3(write_reg[2],ans1[2],ans2[2]);
endmodule