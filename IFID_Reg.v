module IFID_Reg(clk,rst,IFPCin,IFProgMem_in,IDPCout,IDProgMem_out);

input clk,rst;
input [31:0] IFPCin,IFProgMem_in;
output reg [31:0] IDPCout,IDProgMem_out;

always @(posedge clk or posedge rst)
begin    
        if(rst) begin
                    IDPCout <= 32'b00;
                    IDProgMem_out<=32'b00;
        end
        else  begin
                  IDPCout<=IFPCin;
                  IDProgMem_out<= IFProgMem_in;
        end
        
end

endmodule