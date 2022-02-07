`define DELAY 10
module extendImm_tb();
reg[5:0] imm;
wire [31:0] extended;

extendImm extend(extended,imm);


initial begin
imm[5:0] = 6'hF;
#`DELAY;
imm[5:0] = 6'b111111;
#`DELAY;
imm[5:0] = 6'b001011;
#`DELAY;
end
 
 
initial
begin
$monitor("time = %1h, imm =%1b extend=> extended=%1b ", $time, imm, extended);
end
endmodule
