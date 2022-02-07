`define DELAY 20
module equal32_tb();
 // Inputs
 reg [31:0] a;
 reg [31:0] b;
 // Outputs
 wire  answer;
 equal32 equal(
  .a(a), 
  .b(b), 
  .answer(answer)
 );

initial begin
a[31:0] = 32'hFFFF_FFFF; b[31:0] = 32'h0000_0000;
#`DELAY;
a[31:0] = 32'h0F0F0F0F; b[31:0] = 32'h0F0F0F0F;
#`DELAY;
a[31:0] = 32'h1111_AAAA; b[31:0] = 32'h1111_AAAA;
#`DELAY;
a[31:0] = 32'hFFF7_FFFF; b[31:0] = 32'hFFFF_FFFF;
end
 
 
initial
begin
$monitor("time = %1h, a =%1h equal b=%1h => answer=%1b", $time, a, b, answer);
end

endmodule