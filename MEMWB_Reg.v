module MEMWB_Reg(
    input clk, rst,
    // Control signals from MEM stage
    input MEMMemtoReg_in, MEMRegWrite_in,
    
    input [31:0] MEMReadData_in, MEMALURes_in,
    input [4:0] MEMRd_in,

    
    output reg WBMemtoReg_out, WBRegWrite_out,
    output reg [31:0] WBReadData_out, WBALURes_out,
    output reg [4:0] WBRd_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        WBMemtoReg_out <= 1'b0;
        WBRegWrite_out <= 1'b0;
        WBReadData_out <= 32'b0;
        WBALURes_out   <= 32'b0;
        WBRd_out       <= 5'b0;
    end
    else begin
        WBMemtoReg_out <= MEMMemtoReg_in;
        WBRegWrite_out <= MEMRegWrite_in;
        WBReadData_out <= MEMReadData_in;
        WBALURes_out   <= MEMALURes_in;
        WBRd_out       <= MEMRd_in;
    end
end

endmodule
