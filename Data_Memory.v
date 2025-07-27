module Data_Memory(clk,reset,MemWrite,MemRead,read_address,Write_data,MemData_out);

input clk,reset,MemWrite,MemRead;
input [31:0] read_address, Write_data;

output [31:0] MemData_out;

reg [31:0] D_Memory[63:0];

assign MemData_out= (MemRead) ? D_Memory[read_address] : 32'h0;

integer k;
always @(posedge clk)
begin
    if(reset==1'b1)
    begin
        for(k=0; k<64; k=k+1)
        begin
            D_Memory[k]<=32'h0;
        end
    end
    else  if(MemWrite)  D_Memory[read_address]<=Write_data;
    end
 
endmodule