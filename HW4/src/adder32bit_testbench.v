//module adder32Bit(sum,carry_out32,a,b);
`define DELAY 20
module adder32bit_testbench(); 
reg [31:0] a;
reg [31:0]b;
wire[31:0] sum;

adder32bit hatb (
sum, a, b
);

initial begin
a[31:0] = 32'h0000FFFF; b[31:0] = 32'h0000_0001;
#`DELAY;
a[31:0] = 32'h0FFF_FFFF; b[31:0] = 32'h0000_0001;
#`DELAY;
a[31:0] = 32'hABCD_6789; b[31:0] = 32'h0000_AAAA;
#`DELAY;
a[31:0] = 32'h0ABC_FFFF; b[31:0] = 32'h1;
end
 
 
initial
begin
$monitor("time = %1h, a =%1h, b=%1h, sum=%1h", $time, a, b, sum);
end
 
endmodule