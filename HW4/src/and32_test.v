`define DELAY 20
module and32_test;
 // Inputs
 reg [31:0] a;
 reg [31:0] b;
 // Outputs
 wire [31:0] answer;

 and32 and32Gate (
  .a(a), 
  .b(b), 
  .answer(answer)
 );

initial begin
a[31:0] = 32'hFFFF_FFFF; b[31:0] = 32'h0000_0000;
#`DELAY;
a[31:0] = 32'h0F0F0F0F; b[31:0] = 32'hF0F0F0F0;
#`DELAY;
a[31:0] = 32'hABCD_6789; b[31:0] = 32'h1111_AAAA;
#`DELAY;
a[31:0] = 32'hFFF4_FFFF; b[31:0] = 32'h1;
end
 
 
initial
begin
$monitor("time = %1h, a =%1h, b=%1h, answer=%1h", $time, a, b, answer);
end
      
endmodule