
module sub32(sum,a,b);
input[31:0] a,b;
output[31:0] sum;

//wire[31:0] carry_out32;
wire[31:0] reverse_b,reverse_b_plus1;
genvar i;

generate

//half_adder h_adder(sum[0], carry_out32[0],a[0],b[0]);
for(i=0;i<32;i=i+1)
	begin: Adder
	not notGate(reverse_b[i],b[i]);
	//full_adder f_adder(sum[i],carry_out32[i],a[i],b[i],carry_out32[i-1]);
end
//assign oneValue[31:0] = 32'h1;	
//adder32bit adder32 (b,temp,reverse_b,b);
adder32bit adder32 (reverse_b_plus1,reverse_b,32'b1);
adder32bit adder_32 (sum,a,reverse_b_plus1);
endgenerate
endmodule