module mainControl(RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch,ALUctrl,opCode,func);

input [3:0] opCode;
input [2:0] func;
output[2:0] ALUctrl;
output RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch;
wire[2:0] ALUop;
wire E1andE0;
wire E3Not;
wire E2Not;
wire E1Not;
wire E0Not;
wire e2XORe0Wire;

wire E2NotandE1;
wire E1NotAndE0Wire;
wire e2XORe0ANDe1Wire;

wire R,I,B,LW,SW;

wire RNot;
wire ALUop2Not,ALUop0Not;
wire ALUop2and0not,aluop2andaluop0;

not e3(E3Not,opCode[3]);
not e2(E2Not,opCode[2]);
not e1(E1Not,opCode[1]);
not e0(E0Not,opCode[0]);

//p2
or p2(ALUop[2],opCode[3],opCode[2]);

//p1
and E1AndE0(E1andE0,opCode[1],opCode[0]);
and E2notAndE1(E2NotandE1,E2Not,opCode[1]);
or p1(ALUop[1],opCode[3],E1andE0,E2NotandE1);


//p0
and e1NotAndE0(E1NotAndE0Wire,E1Not,opCode[0]);
xor e2XORe0(e2XORe0Wire,opCode[2],opCode[0]);
and e2XORe0ANDe1(e2XORe0ANDe1Wire,opCode[1],e2XORe0Wire);
or p0(ALUop[0],opCode[3],E1NotAndE0Wire,e2XORe0ANDe1Wire);

//fill ALU ctrl
ALUcontrol ALUcontrolModule(ALUctrl,ALUop,func);
not aluOp2NotGate(ALUop2Not,ALUop[2]);
not aluOp0NotGate(ALUop0Not,ALUop[0]);
// R
and Rgate(R,E3Not,E2Not,E1Not,E0Not);
//wire RNot;
//wire ALUop2Not,ALUop0Not; ALUop2Notandnot0
// I 
not rNotGate(RNot,R);
//not ALUop2NotGate(ALUop2Not,ALUop[2]);
//not ALUop0NotGate(ALUop0Not,ALUop[0]);
//wire ALUop2and0not,aluop2andaluop0;
and aluop(aluop2andaluop0,ALUop[2],ALUop[0]);
not aluopsNot(ALUop2and0not,aluop2andaluop0);
and Igate(I,RNot,ALUop2and0not);

//B
wire b2;
xor b2Gate(b2,opCode[1],opCode[0]);
and Bgate(B,opCode[2],b2);

// LW
and lwGate(LW,opCode[3],E0Not);

//SW
and swGate(SW,opCode[3],opCode[0]);

and RDgate(RegDst,R,1'b1);

or ALUsrcGate(ALUSrc,I,LW,SW);

and MemtoRegGate(MemtoReg,LW,1'b1);

or regWrtGate(RegWrt,R,I,LW);

and memReadgate(MemRead,LW,1'b1); 

and memWritegate(MemWrite,SW,1'b1);

and Branchgate(Branch,B,1'b1);  


endmodule