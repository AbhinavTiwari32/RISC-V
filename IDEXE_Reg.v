module IDEXE_Reg(input clk,rst,
input IDALUSrc_in, IDMemtoReg_in, IDRegWrite_in, IDMemRead_in, IDMemWrite_in, IDBranch_in, 
input [1:0] IDALUOp_in,
input [31:0] IDPC_in,
input [31:0] IDRd1_in,IDRd2_in,
input [31:0] IDImmGen_in,
input [2:0] IDfunc3_in,
input IDfunc7_in,
input [4:0] IDRd_in,

output reg EXEALUSrc_out, EXEMemtoReg_out, EXERegWrite_out, EXEMemRead_out, EXEMemWrite_out, EXEBranch_out, 
output reg [1:0] EXEALUOp_out,
output reg [31:0] EXEPC_out,
output reg [31:0] EXERd1_out,EXERd2_out,
output reg [31:0] EXEImmGen_out,
output reg [2:0] EXEfunc3_out,
output reg EXEfunc7_out,
output reg [4:0] EXERd_out);

always @(posedge clk or posedge rst) begin

    if(rst) begin
     
        EXEALUSrc_out<=1'b0;
        EXEMemtoReg_out<=1'b0;
        EXERegWrite_out<=1'b0;
        EXEMemRead_out<=1'b0;
        EXEMemWrite_out<=1'b0;
        EXEBranch_out<=1'b0;

        EXEALUOp_out<=2'b00;
         EXEPC_out<=32'b00;
        EXERd1_out<=32'b00;
        EXERd2_out<=32'b00;
        EXEImmGen_out<=32'b00;
        EXEfunc3_out<=3'b00;
        EXEfunc7_out<=1'b0;

        EXERd_out<=5'b00;



    end
    else  begin
        EXEALUSrc_out<=IDALUSrc_in;
        EXEMemtoReg_out<=IDMemtoReg_in;
        EXERegWrite_out<= IDRegWrite_in;
        EXEMemRead_out<= IDMemRead_in;
        EXEMemWrite_out<= IDMemWrite_in;
        EXEBranch_out<=IDBranch_in;

        EXEALUOp_out<=IDALUOp_in;
        EXEPC_out<=IDPC_in;
        EXERd1_out<=IDRd1_in;
        EXERd2_out<=IDRd2_in;
        EXEImmGen_out<=IDImmGen_in;
        EXEfunc3_out<=IDfunc3_in;
        EXEfunc7_out<=IDfunc7_in;
        EXERd_out<=IDRd_in;



    end

         


end



endmodule