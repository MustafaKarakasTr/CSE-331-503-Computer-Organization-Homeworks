
`define DELAY 5
module alu32_test();



reg [31:0] a;
reg [31:0]b;
reg [2:0] aluOp;
wire[31:0] answer;


alu32 hatb (
answer,a, b,aluOp
);

initial begin
a[31:0] = 32'h000000A0; b[31:0] = 32'hA; aluOp[2:0] = 3'b000; // add answer is = AA
#`DELAY;
a[31:0] = 32'h0000140E; b[31:0] = 32'h23A2; aluOp[2:0] = 3'b000; // add answer is = 37B0
#`DELAY;
a[31:0] = 32'hFFFF_0000; b[31:0] = 32'hFF00_FF00;aluOp[2:0] = 3'b001; // xor answer = FF_FF00
#`DELAY;
a[31:0] = 32'hF0F0_0F0F; b[31:0] = 32'hFF00_FF00;aluOp[2:0] = 3'b001; // xor answer = 0FF0_F00F
#`DELAY;
a[31:0] = 32'b10; b[31:0] = 32'b10;aluOp[2:0] = 3'b010; // subtraction answer = B0
#`DELAY;
a[31:0] = 32'hA0BE; b[31:0] = 32'hA03F;aluOp[2:0] = 3'b010; // subtraction answer = 7f
#`DELAY;
a[31:0] = 32'h0FFF_0000; b[31:0] = 32'h0000_FFFF;aluOp[2:0] = 3'b100; // less answer = 0
#`DELAY;
a[31:0] = 32'h1000; b[31:0] = 32'h0FFF_FFFF;aluOp[2:0] = 3'b100; // less answer = 1
#`DELAY;
a[31:0] = 32'hFFFF_0000; b[31:0] = 32'hFF00_FF00;aluOp[2:0] = 3'b101; // nor answer = 0000_00FF
#`DELAY;
a[31:0] = 32'hAAAA_0000; b[31:0] = 32'hAA00_AA00;aluOp[2:0] = 3'b101; // nor answer = 5555_55FF
#`DELAY;
a[31:0] = 32'hFFFF_0000; b[31:0] = 32'hFF00_FF00;aluOp[2:0] = 3'b110; // and answer = FF00_0000
#`DELAY;
a[31:0] = 32'hAAAA_0000; b[31:0] = 32'h000A_AAAA;aluOp[2:0] = 3'b110; // and answer = 000A_0000
#`DELAY;
a[31:0] = 32'hFFFF_0000; b[31:0] = 32'hFF00_FF00;aluOp[2:0] = 3'b111; // or answer = FFFF_FF00
#`DELAY;
a[31:0] = 32'hAAAA_0000; b[31:0] = 32'hAA00_AA00;aluOp[2:0] = 3'b111; // or answer = AAAA_AA00
end
 
 
initial
begin
$monitor("time = %3d, a =%1h, b=%1h, result=%10h aluOp=%1b", $time, a, b,answer,aluOp);
end
 
endmodule