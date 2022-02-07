`define DELAY 10
module mux2x1ThreeBits_tb();

reg[2:0] read_reg2,write_regRegDst1;
wire[2:0] write_reg;
reg RegDst;

mux2x1ThreeBits mux(write_reg,read_reg2,write_regRegDst1,RegDst);

initial begin
read_reg2[2:0] = 3'b110; write_regRegDst1[2:0] = 3'b001; RegDst = 1'b0;
#`DELAY;
read_reg2[2:0] = 3'b100; write_regRegDst1[2:0] = 3'b011;RegDst = 1'b1;
#`DELAY;
read_reg2[2:0] = 3'b110; write_regRegDst1[2:0] = 3'b111;RegDst = 1'b0;
#`DELAY;
read_reg2[2:0] = 3'b010; write_regRegDst1[2:0] = 3'b101;RegDst = 1'b1;
end
 
 
initial
begin
$monitor("time = %1h, read_reg2 =%1b, b=%1b, sum=%1b,regdst = %1b", $time, read_reg2, write_regRegDst1, write_reg,RegDst);
end
endmodule