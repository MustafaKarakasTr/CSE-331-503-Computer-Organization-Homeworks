//module _4bit_adder (S,C,A,B,C0);
`define DELAY 10
module ALUcontrol_tb;
 // Inputs
 
 reg [2:0] func;
 reg [2:0] ALUop;
 wire[2:0] ALUctrl;
 // Instantiate the Unit Under Test (UUT)
 ALUcontrol uut (
 ALUctrl,
 ALUop,
 func
 );

 initial begin
func[2:0] = 3'b000; 
ALUop[2:0] = 3'b000;
#`DELAY;
func[2:0] = 3'b001; 
#`DELAY;
func[2:0] = 3'b010; 
#`DELAY;
func[2:0] = 3'b011; 
#`DELAY;
func[2:0] = 3'b100; 
#`DELAY;
func[2:0] = 3'b101; 
#`DELAY;


ALUop[2:0] = 3'b001; 
#`DELAY;
ALUop[2:0] = 3'b010; 
#`DELAY;
ALUop[2:0] = 3'b011; 
#`DELAY;
ALUop[2:0] = 3'b100; 
#`DELAY;
ALUop[2:0] = 3'b101; 
#`DELAY;
ALUop[2:0] = 3'b110; 
#`DELAY;
ALUop[2:0] = 3'b111; 
#`DELAY;
 end
initial
begin
$monitor("time = %3d, a =%1b, b=%1b =, ans=%1b", $time, func, ALUop,ALUctrl);
end  
endmodule