
module less32(answer,a,b);
input[31:0] a,b;
output answer;
wire[31:0] sub;






sub32 sub_32 (sub,a,b);
and ans(answer,sub[31],1);

endmodule