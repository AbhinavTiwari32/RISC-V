module Control_Unit(
    input [6:0] instruction,
    output reg Branch, MemRead, MemtoReg, MemWrite,
    output reg ALUSrc, RegWrite,
    output reg [1:0] ALUOp
);

always @(*) begin
    case(instruction)
        7'b0110011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b001000_10; // R-type
        7'b0000011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b111100_00; // LW
        7'b0100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b100010_00; // SW
        7'b0010011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b101000_00; // I-type ALU (e.g., ADDI, ORI)
        7'b1100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b000001_01; // Branch
        7'b1101111: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b101000_00; // JAL
        7'b1100111: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b101000_00; // JALR
        default:    {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} = 8'b000000_00;
    endcase
end

endmodule