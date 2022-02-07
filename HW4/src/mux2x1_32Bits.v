module mux2x1_32Bits(aluInput2,read_data_2,imm32Bit,ALUSrc);
output [31:0] aluInput2;
input  [31:0] read_data_2,imm32Bit;
wire [31:0] ans1,ans2;
input wire ALUSrc;
wire notALUSrc;
not reverseALUSrc(notALUSrc,ALUSrc);

genvar i;
generate

for(i=0;i<32;i=i+1)
	begin: Adder
	and and1(ans1[i],read_data_2[i],notALUSrc);
	and and2(ans2[i],imm32Bit[i],ALUSrc);
	or findaluInput2(aluInput2[i],ans1[i],ans2[i]);
end	
endgenerate


endmodule