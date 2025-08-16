module EXMEM_Reg(input clk,rst,
    input EXMemtoReg_in, EXRegWrite_in, EXMemRead_in, EXMemWrite_in, EXBranch_in,
input [31:0] EXADD_in,EXALURes_in,
input [31:0] EXRd2_in,
input [4:0] EXRd_in,
input EXZero_in,
output reg MEMMemtoReg_out, MEMRegWrite_out, MEMMemRead_out, MEMMemWrite_out, MEMBranch_out,
output reg [31:0] MEMADD_out,MEMALURes_out,
output reg [31:0] MEMRd2_out, 
output reg [4:0] MEMRd_out,
output reg MEMZero_out);

always @(posedge clk or posedge rst) begin
    if(rst) begin
       MEMMemtoReg_out<=1'b0;
       MEMRegWrite_out<=1'b0;
       MEMMemRead_out<=1'b0;
       MEMMemWrite_out<=1'b0;
       MEMBranch_out <=1'b0;
       MEMADD_out<= 32'b00;
       MEMALURes_out<=32'b00;

      MEMRd2_out <=32'b00;
       MEMRd_out <=5'b00;
       MEMZero_out<=1'b0;
 end

 else  begin
     MEMMemtoReg_out<=EXMemtoReg_in;
       MEMRegWrite_out<=EXRegWrite_in;
       MEMMemRead_out<=EXMemRead_in;
       MEMMemWrite_out<=EXMemWrite_in;
       MEMBranch_out <=EXBranch_in;
       MEMADD_out<= EXADD_in;
       MEMALURes_out<=EXALURes_in;

      MEMRd2_out <=EXRd2_in;
       MEMRd_out <= EXRd_in;
       MEMZero_out<=EXZero_in;
   

 end


end




endmodule