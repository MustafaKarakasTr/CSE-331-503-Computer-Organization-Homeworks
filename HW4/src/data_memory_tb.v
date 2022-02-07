`define DELAY 10
module data_memory_tb();
	wire [31:0] read_data;
	reg clk;
	reg [31:0] write_data,address;
	reg mem_write,mem_read;
	reg [31:0] memory[255:0];
 data_memory dm(read_data,write_data, address, mem_write, mem_read,clk );
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
	write_data = 32'hFF;
	address = 32'h5;
	mem_write = 1'b1;
	mem_read = 1'b0;
	#`DELAY;
	
	address = 32'h5;
	mem_write = 1'b0;
	mem_read = 1'b1;
	#`DELAY;
	
	write_data = 32'hFFFF_ABCD;
	address = 32'h5;
	mem_write = 1'b1;
	mem_read = 1'b0;
	#`DELAY;
	
	address = 32'h5;
	mem_write = 1'b0;
	mem_read = 1'b1;
	#`DELAY;
		
	end
initial begin
$readmemb("data.txt", dm.memory);
end
initial
begin
$monitor("time : %1d,writeCommand: %1b, address = %1h,written=%1h, readCommand = %1b,read: %1h",$time,mem_write,address,write_data,mem_read,read_data);

end  
endmodule