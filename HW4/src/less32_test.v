//module adder32Bit(sum,carry_out32,a,b);
`define DELAY 20
module less32_test(); 
reg [31:0] a;
reg [31:0]b;
wire answer;

less32 hatb (
answer, a, b
);

initial begin
a[31:0] = 32'h000000A0; b[31:0] = 32'hA;
#`DELAY;
a[31:0] = 32'hF0; b[31:0] = 32'hFF;
#`DELAY;
a[31:0] = 32'hB; b[31:0] = 32'hA;
#`DELAY;
a[31:0] = 32'h1; b[31:0] = 32'h0FFF_FFFF;
end
 
 
initial
begin
$monitor("time = %1d, a =%1d, b=%1d, A<B=%1d", $time, a, b, answer);
end
 
endmodule