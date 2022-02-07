module ALUcontrol(ALUctrl,ALUop,func);
output[2:0] ALUctrl; 
input[2:0] ALUop;
input [2:0] func;
wire E1andE0;
wire P2Not;
wire P1Not;
wire P0Not;

wire F1Not;
wire F0Not;
wire notF1andnotF0Wire;
wire allNotAluOpWire;
wire c2First;
wire c2Second;
wire c2Wire;
wire f2OrNotF1AndNotF0;
wire notP2AndP1,p2AndNotP0;


//c1wires
wire c11Wire;
wire f2XNORf0;
wire p2notP1p0;
wire c12Wire;
//c0 wires
wire c02;
wire f1andf0,c01,notP2P1P0,p2NotP1NotP0;


not e2(P2Not,ALUop[2]);
not e1(P1Not,ALUop[1]);
not e0(P0Not,ALUop[0]);

not f1Not(F1Not,func[1]);
not f0Not(F0Not,func[0]);


and allNotAluOp(allNotAluOpWire,P2Not,P1Not,P0Not); //p2' p1' p0'

and notF1andnotF0(notF1andnotF0Wire,F1Not,F0Not); // F1'.F0'

//c2
or c22(f2OrNotF1AndNotF0,func[2],notF1andnotF0Wire);//(f2 + F1'.F0')

and c21(c2First,allNotAluOpWire,f2OrNotF1AndNotF0);//(p2' p1' p0') (F2+ F1'.F0')

and notP2AndP1Gate(notP2AndP1,P2Not,ALUop[1]);
and p2AndNotP0Gate(p2AndNotP0,ALUop[2],P0Not);

or c2SecondGate(c2Second,notP2AndP1,p2AndNotP0);

or c2All(ALUctrl[2],c2First,c2Second);

//c1
xnor f2f0(f2XNORf0,func[2],func[0]);
and c11(c11Wire,allNotAluOpWire,f2XNORf0);
and p2notP1p0Gate(p2notP1p0,ALUop[2],P1Not,ALUop[0]);
or c12(c12Wire,notP2AndP1,p2notP1p0);
or c1Ans(ALUctrl[1],c11Wire,c12Wire);

//c0
and f1andF0Gate(f1andf0,func[1],func[0]);
or c02Gate(c02,f1andf0,func[2]);
and c01Gate(c01,allNotAluOpWire,c02);

and p2NotP1NotP0Gate(p2NotP1NotP0,ALUop[2],P1Not,P0Not);
and notP2P1P0Gate(notP2P1P0,notP2AndP1,ALUop[0]);
or c0Gen(ALUctrl[0],c01,p2NotP1NotP0,notP2P1P0);


endmodule