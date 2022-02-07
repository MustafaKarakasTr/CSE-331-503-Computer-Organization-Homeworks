//module half_adder(sum, carry_out, a, b);
//module full_adder(sum, carry_out32, a, b, carry_in);

module shift_right(answer,a);
input[63:0] a;
output[63:0] answer;

genvar i;

generate
for(i=1;i<64;i=i+1)
	begin: Shift
	and andForShift(answer[i-1],a[i],64'hFFFFFFFF);
end	
and lastAnd(answer[63],64'b0,64'b0);
endgenerate

endmodule