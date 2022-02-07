module xor32(answer,a,b);

input[31:0] a,b;
output[31:0] answer;

genvar i;
generate

for(i=0;i<32;i=i+1)
	begin: Adder
	xor xorGate(answer[i],a[i],b[i]);
end	
endgenerate
endmodule
