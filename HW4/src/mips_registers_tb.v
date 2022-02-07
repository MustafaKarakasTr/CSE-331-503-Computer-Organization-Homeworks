`define DELAY 10
module mips_registers_tb();
reg clk;
wire [31:0] read_data_1, read_data_2;
reg [31:0] write_data;
reg [2:0] read_reg_1, read_reg_2, write_reg;
reg signal_reg_write;

 mips_registers mr( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );
 initial
	begin
		clk = 1'b1;
	end

always
	begin
		#1 clk = ~clk;
	end
initial 
	begin
	write_data = 32'hFFFF_AAAA;
	write_reg = 3'h1;
	signal_reg_write = 1'b1;
	#`DELAY;
	
	read_reg_1 = 3'h1;
	signal_reg_write = 1'b0;
	#`DELAY;
	
	write_data = 32'hFFFF_AAAA; // Zero register's content can not be changed
	write_reg = 3'h0;
	signal_reg_write = 1'b1;
	#`DELAY;

	read_reg_1 = 3'h0;
	signal_reg_write = 1'b0;
	#`DELAY;	
	end
initial begin
$readmemb("registers.mem", mr.registers);

end

initial
begin
$monitor("time : %1d,read_data_1 = %1h, read_data_2= %1h, write_data= %1h, read_reg_1= %1b, read_reg_2= %1b, write_reg= %1b, signal_reg_write= %1b",$time,read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write);

end  
endmodule