module extendImm(imm32Bit,immidiate);
input[5:0]immidiate;
output [31:0] imm32Bit;
wire[31:0] temp;

and takeImm1(temp[0],1'b1,immidiate[0]);
and takeImm2(temp[1],1'b1,immidiate[1]);
and takeImm3(temp[2],1'b1,immidiate[2]);
and takeImm4(temp[3],1'b1,immidiate[3]);
and takeImm5(temp[4],1'b1,immidiate[4]);
and takeImm6(temp[5],1'b1,immidiate[5]);


and32 andGate(imm32Bit,32'b00000000_00000000_00000000_00111111,temp);
endmodule