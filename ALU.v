module ALU_unit(
    input [31:0] A, B,
    input [3:0] Control_in,
    output reg [31:0] ALU_Result,
    output reg zero
);

always @(Control_in or A or B) begin
    case (Control_in)
        4'b0000: ALU_Result = A & B;      // AND
        4'b0001: ALU_Result = A | B;      // OR
        4'b0010: ALU_Result <= A + B;      // ADD
        4'b0011: ALU_Result = A ^ B;      // XOR
        4'b0100: ALU_Result = (A < B) ? 1 : 0;  // SLT
        4'b0101: ALU_Result = A << B[4:0];     // SLL
        4'b1001: ALU_Result = A >> B[4:0];     // SRL
        4'b1010: ALU_Result = $signed(A) >>> B[4:0]; // SRA
        4'b0110: ALU_Result = A - B;      // SUB
        default: ALU_Result = 0;
    endcase

    zero = (ALU_Result == 0) ? 1 : 0;
end

endmodule