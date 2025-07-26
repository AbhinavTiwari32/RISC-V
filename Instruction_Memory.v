module Instruction_Memory(reset, read_address, instruction_out);

input reset;

input [31:0] read_address;
output [31:0] instruction_out;

reg [31:0] Memory [63:0];

assign instruction_out=Memory[read_address];
integer k;
always @(posedge reset)
  begin
    for(k=0; k<64; k=k+1)
    begin
        Memory[k]=32'h00000000;
    end
end
endmodule