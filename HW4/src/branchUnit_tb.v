`define DELAY 10
module branchUnit_tb();
wire[31:0] newPc;
reg beqCommand;
reg [31:0] noBranchNewPc;
reg [31:0] write_data;
reg [31:0] imm;
reg Branch;
branchUnit bu(newPc,noBranchNewPc,write_data,imm,Branch,beqCommand); 
initial begin
beqCommand = 1'b1;
noBranchNewPc = 32'hFB;
write_data = 32'h0;
imm = 32'h4;
Branch = 1'b1;
#`DELAY; // branch == successful

beqCommand = 1'b1;
noBranchNewPc = 32'hFB;
write_data = 32'h0;
imm = 32'h4;
Branch = 1'b0;
#`DELAY;  // branch != successful

beqCommand = 1'b1;
noBranchNewPc = 32'hFB;
write_data = 32'hF;
imm = 32'h4;
Branch = 1'b1;
#`DELAY; // branch != successful

beqCommand = 1'b0;
noBranchNewPc = 32'hFB;
write_data = 32'hF;
imm = 32'h4;
Branch = 1'b1;
#`DELAY; // branch == successful

beqCommand = 1'b0;
noBranchNewPc = 32'hFB;
write_data = 32'h0;
imm = 32'h4;
Branch = 1'b1;
#`DELAY; // branch != successful

beqCommand = 1'b0;
noBranchNewPc = 32'hFB;
write_data = 32'hF;
imm = 32'h4;
Branch = 1'b0;
#`DELAY; // branch != successful
end
 
 
initial
begin
$monitor("time = %1h, beqCommand =%1h, noBranchNewPc=%1h, write_data=%1h,imm=%1h,Branch=%1h, newPc = %1h", $time, beqCommand,noBranchNewPc,write_data,imm,Branch,newPc);
end

endmodule