`define DELAY 10
module instruction_memory_tb();
reg clk;
wire [15:0] instruction_set;
wire [31:0] newPc;

 reg [31:0] readAddress;
 instruction_memory uut(instruction_set,newPc,readAddress,clk);  
 initial
	begin
		clk = 1'b1;
		readAddress <=0;
	end
always
	begin
		#1 clk = ~clk;
	end
always 
	begin
		#`DELAY;
		if(readAddress>10)
		begin
			$stop;
		end	
		else
			begin
				readAddress<=newPc;
			end
	end
initial begin
$readmemb("instructions.txt", uut.instructions);
end

initial
begin
$monitor("time : %1d,instruction: %1b, address = %1d,newPc=%1d",$time,instruction_set,readAddress,newPc);
end  
endmodule