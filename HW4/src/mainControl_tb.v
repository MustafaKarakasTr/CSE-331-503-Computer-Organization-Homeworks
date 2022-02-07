//module _4bit_adder (S,C,A,B,C0);
`define DELAY 10
module mainControl_tb;
 // Inputs
 
 reg [3:0] opCode;
 reg [2:0] func;
 wire [2:0] ALUCtrl;
 wire RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch;
 // Instantiate the Unit Under Test (UUT)
 mainControl uut (
 RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch,
 ALUCtrl,
 opCode,
 func
 );

 initial begin
opCode[3:0] = 4'b0000;
func[2:0] = 3'b000; 
#`DELAY;
opCode[3:0] = 4'b0000;
func[2:0] = 3'b001; 
#`DELAY;
opCode[3:0] = 4'b0000;
func[2:0] = 3'b010; 
#`DELAY;
opCode[3:0] = 4'b0000;
func[2:0] = 3'b011; 
#`DELAY;
opCode[3:0] = 4'b0000;
func[2:0] = 3'b100; 
#`DELAY;
opCode[3:0] = 4'b0000;
func[2:0] = 3'b101; 
#`DELAY;

opCode[3:0] = 4'b0001; 
#`DELAY;
opCode[3:0] = 4'b0010; 
#`DELAY;
opCode[3:0] = 4'b0011; 
#`DELAY;
opCode[3:0] = 4'b0100; 
#`DELAY;
opCode[3:0] = 4'b0101; 
#`DELAY;
opCode[3:0] = 4'b0110; 
#`DELAY;
opCode[3:0] = 4'b0111; 
#`DELAY;
opCode[3:0] = 4'b1000; 
#`DELAY;
opCode[3:0] = 4'b1001; 
#`DELAY;

 end
initial
begin
$monitor("time = %3d, a =%1b, b=%1b , aluCtrl= %1b,RegDst= %1b,ALUSrc= %1b,MemtoReg= %1b,RegWrt= %1b,MemRead= %1b,MemWrite= %1b,Branch= %1b,I TYPE : %1b", $time,opCode, func,ALUCtrl,RegDst,ALUSrc,MemtoReg,RegWrt,MemRead,MemWrite,Branch,uut.I,);
end  
endmodule