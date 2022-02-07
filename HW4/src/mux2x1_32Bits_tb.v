`define DELAY 10
module mux2x1_32Bits_tb();

reg[31:0] input1,input2;
wire[31:0] out;
reg select;

 mux2x1_32Bits mux(out,input1,input2,select);
initial begin
input1 = 32'b110; input2 = 32'b001; select = 1'b0;
#`DELAY;
input1 = 32'b110; input2 = 32'b001; select = 1'b1;
#`DELAY;

end
 
 
initial
begin
$monitor("time = %1h, input1 = %1b,input2 = %1b,select = %1b,output = %1b", $time, input1,input2,select,out);
end
endmodule