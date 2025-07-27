module Instruction_Memory(
    input clk,
    input reset,
    input [31:0] read_address,
    output [31:0] instruction_out
);

reg [31:0] I_Mem[0:63];


assign instruction_out = I_Mem[read_address[31:2]];

integer k;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        
        for (k = 0; k < 64; k = k + 1) begin
            I_Mem[k] <= 32'h00000000;
        end

        
        I_Mem[0]  <= 32'b0000000001100100000110001100011;
;
        // I_Mem[1]<=32'b0100000_00111_00110_000_00101_0110011;
        // I_Mem[2]<= 32'b00000000011100110110001010110011;
        // I_Mem[3]<= 32'b0000000_00111_00110_111_00101_0110011;
        // I_Mem[4]<=32'b0000000_00111_00110_100_00101_0110011;
        // I_Mem[5]<=32'b000000001010_00001_000_00111_0010011;
        // I_Mem[6]<=32'b00000000110100101110001100010011;




        
        




        


         // add x3, x1, x2
//         I_Mem[1]  <= 32'h00A08193;  // addi x3, x1, 10
//         I_Mem[2]  <= 32'h00408203;  // lw x4, 4(x1)
//         I_Mem[3]  <= 32'h0060A423;  // sw x6, 8(x1)
//         I_Mem[4]  <= 32'h004182B3;  // add x5, x3, x4
//        I_Mem[5]  <= 32'h404202B3;  // sub x5, x4, x4
// I_Mem[6]  <= 32'h0062C2B3;  // or  x5, x5, x6
// I_Mem[7]  <= 32'h0072E2B3;  // and x5, x5, x7
// I_Mem[8] <= 32'hFFF3C483;  // lw x9, -1(x7)
// I_Mem[9]  <= 32'h00520313;  // addi x6, x4, 5
// I_Mem[10] <= 32'hFF520313;  // addi x6, x4, -11
// I_Mem[11] <= 32'h00432383;  // lw x7, 4(x6)
// I_Mem[12] <= 32'h00034403;  // lw x8, 0(x6)



    end
end

endmodule
