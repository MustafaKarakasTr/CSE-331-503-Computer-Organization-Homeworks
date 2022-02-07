`define DELAY 20
module shift_right_tb;
 // Inputs
 reg [63:0] a;
 // Outputs
 wire [63:0] answer;

 shift_right shift (
   .answer(answer),
  .a(a)

 );

initial begin
a[63:0] = 64'hFFFF_FFFF; 
#`DELAY;
a[63:0] = 64'h0F0F0F0F;
#`DELAY;
a[63:0] = 64'hABCD_6789;
#`DELAY;
a[63:0] = 64'hFFF4_FFFF;
end
 
 
initial
begin
$monitor("time = %1h, a =%1h, answer=%1h", $time, a, answer);
end
      
endmodule