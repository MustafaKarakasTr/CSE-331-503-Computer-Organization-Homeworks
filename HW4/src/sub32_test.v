`define DELAY 20
module sub32_test(); 
reg [31:0] a;
reg [31:0]b;
wire[31:0] sub;

sub32 hatb (
sub, a, b
);

initial begin
a[31:0] = 32'b10; b[31:0] = 32'b10;
#`DELAY;
a[31:0] = 32'hFF; b[31:0] = 32'hF0;
#`DELAY;
a[31:0] = 32'h000000A0; b[31:0] = 32'hA;
#`DELAY;
a[31:0] = 32'h0FFF_FFFF; b[31:0] = 32'h1;
end
 
 
initial
begin
$monitor("time = %1d, a =%1h, b=%1h, a-b=%1h", $time, a, b, sub);
end
 
endmodule