//module half_adder(sum, carry_out, a, b);
//module full_adder(sum, carry_out32, a, b, carry_in);

module alu32(result,a,b,ALUop);
input[31:0] a,b;
input[2:0] ALUop;

output[31:0] result;

wire[31:0] result1;
wire[31:0] result2;
wire[31:0] result3;
wire result4;
wire[31:0] result4_32bit;
wire[31:0] result5;
wire[31:0] result6;
wire[31:0] result7;
wire[31:0] result8;

wire[31:0] result12;
wire[31:0] result34;
wire[31:0] result1234;


wire[31:0] result56;
wire[31:0] result567;

//wire[31:0] result78;
//output resultALU;
//output addOp;

wire[2:0] ALUopNot;
wire[31:0] addAnswer;
wire[31:0] xorAnswer;
wire[31:0] subAnswer;
wire[31:0] multAnswer;
wire sltAnswer;
wire[31:0] norAnswer;
wire[31:0] andAnswer;
wire[31:0] orAnswer;

wire addAluCode;
wire xorAluCode;
wire subAluCode;
wire multAluCode;
wire sltAluCode;
wire norAluCode;
wire andAluCode;
wire orAluCode;

//reverse ALUop
not not1(ALUopNot[2],ALUop[2]);
not not2(ALUopNot[1],ALUop[1]);
not not3(ALUopNot[0],ALUop[0]);



and add1OpCheck(addAluCode,ALUopNot[2],ALUopNot[1],ALUopNot[0]); // 000
adder32bit add(addAnswer,a,b);
and32 andAdd(result1,addAnswer, { 32{addAluCode} });


and and2OpCheck(xorAluCode,ALUopNot[2],ALUopNot[1],ALUop[0]); //001
xor32 xorOp(xorAnswer,a,b);
and32 andXOR(result2,xorAnswer, { 32{xorAluCode} });


and and3OpCheck(subAluCode,ALUopNot[2],ALUop[1],ALUopNot[0]); //010
sub32 subOp(subAnswer,a,b);
and32 andSub(result3,subAnswer, { 32{subAluCode} });


//011 mult

and and4OpCheck(sltAluCode,ALUop[2],ALUopNot[1],ALUopNot[0]);//100
less32 lessOp(sltAnswer,a,b);
and andSlt(result4,sltAnswer,sltAluCode);
genvar i;
generate
or orOperator(result4_32bit[0],result4,0); // make result4 32 bit
for(i=1;i<32;i=i+1)
	begin: Adder
	or orOperatorr(result4_32bit[i],0,0);
end	
endgenerate

and and5OpCheck(norAluCode,ALUop[2],ALUopNot[1],ALUop[0]); //101
nor32 norOp(norAnswer,a,b);
and32 andNOR(result5,norAnswer, { 32{norAluCode} });

and and6OpCheck(andAluCode,ALUop[2],ALUop[1],ALUopNot[0]); //110
and32 andOp(andAnswer,a,b);
and32 andAND(result6,andAnswer, { 32{andAluCode} });

and and7OpCheck(orAluCode,ALUop[2],ALUop[1],ALUop[0]); //111
or32 orOp(orAnswer,a,b);
and32 andOR(result7,orAnswer, { 32{orAluCode} });

or32 or32Op1(result12,result1,result2);
or32 or32Op2(result34,result3,result4_32bit);
or32 or32Op3(result1234,result12,result34);
or32 or32Op4(result56,result5,result6);
or32 or32Op5(result567,result56,result7);
or32 or32Op(result,result1234,result567);
 
//and xorOp()


endmodule