module Register_File(clk,reset, Rs1, Rs2, Rd,Write_data,RegWrite,read_data1,read_data2);

input clk, reset,RegWrite;

input [4:0] Rs1;
input [4:0] Rs2;
input [4:0] Rd;
input [31:0] Write_data;

output [31:0] read_data1, read_data2;

reg [31:0] Registers[31:0];

initial begin

        Registers[0]  = 32'd0;
        Registers[1]  = 32'd12;
        Registers[2]  = 32'd0;
        Registers[3]  = 32'd1;
        Registers[4]  = 32'd1;
        Registers[5]  = 32'd45;
        Registers[6]  = 32'd45;
        Registers[7]  = 32'd1;
        Registers[8]  = 32'd78;
        Registers[9]  = 32'd89;
        Registers[10] = 32'd90;
        Registers[11] = 32'd11;
        Registers[12] = 32'd22;
        Registers[13] = 32'd33;
        Registers[14] = 32'd44;
        Registers[15] = 32'd55;
        Registers[16] = 32'd66;
        Registers[17] = 32'd77;
        Registers[18] = 32'd88;
        Registers[19] = 32'd99;
        Registers[20] = 32'd100;
        Registers[21] = 32'd111;
        Registers[22] = 32'd122;
        Registers[23] = 32'd133;
        Registers[24] = 32'd144;
        Registers[25] = 32'd155;
        Registers[26] = 32'd166;
        Registers[27] = 32'd177;
        Registers[28] = 32'd188;
        Registers[29] = 32'd199;
        Registers[30] = 32'd200;
        Registers[31] = 32'd255;
end





integer k;
always @(posedge clk or posedge reset)
  begin
//     if(reset==1'b1) begin
//     for(k=0; k<32; k=k+1)
//     begin
//     Registers[k]<=32'h0;
//     end
// end

if(RegWrite && Rd != 0) begin
        Registers[Rd] <= Write_data;
    
end
end
assign read_data1 =Registers[Rs1];
assign read_data2 =Registers[Rs2];




endmodule