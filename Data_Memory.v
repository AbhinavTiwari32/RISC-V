module Data_Memory(clk,reset,MemWrite,MemRead,read_address,Write_data,MemData_out);

input clk,reset,MemWrite,MemRead;
input [31:0] read_address, Write_data;

output [31:0] MemData_out;

reg [31:0] D_Memory[63:0];
initial begin 
  D_Memory[15]=32'd32;
end

assign MemData_out= (MemRead) ? D_Memory[read_address>>2] : 32'h0;

integer k;
always @(posedge clk or posedge reset)
begin
    if(reset==1'b1)
    begin
        for(k=0; k<64; k=k+1)
        begin
            D_Memory[k]<=k;
        end
    end
    else  if(MemWrite)  D_Memory[read_address>>2]<=Write_data;
    end
 
endmodule