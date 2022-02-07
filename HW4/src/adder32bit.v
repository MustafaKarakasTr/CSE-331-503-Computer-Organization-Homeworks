//module half_adder(sum, carry_out, a, b);
//module full_adder(sum, carry_out32, a, b, carry_in);

module adder32bit(sum,a,b);
input[31:0] a,b;
output[31:0] sum;

wire[31:0] carry_out32;

genvar i;

generate
half_adder h_adder(sum[0], carry_out32[0],a[0],b[0]);
for(i=1;i<32;i=i+1)
	begin: Adder
	full_adder f_adder(sum[i],carry_out32[i],a[i],b[i],carry_out32[i-1]);
end	
endgenerate
endmodule