module equal32(answer,a,b);
input[31:0] a,b;
output answer;
wire[31:0] check;

genvar i;
generate

for(i=0;i<32;i=i+1)
	begin: Adder
	xnor xnorGate(check[i],a[i],b[i]);
end	
endgenerate
and ifAnyOfThemIsZeroThenAnswerIsZero(answer,check[0],check[1],check[2],check[3],check[4],check[5],check[6],check[7],check[8],
															check[9],check[10],check[11],check[12],check[13],check[14],check[15],check[16],
															check[17],check[18],check[19],check[20],check[21],check[22],check[23],check[24],
															check[25],check[26],check[27],check[28],check[29],check[30],check[31]);


endmodule