module ALU_Control(
    input [1:0] ALUOp,
    input fun7,
    input [2:0] fun3,
    output reg [3:0] Control_out
);

always @(*) begin
    case(ALUOp)
        2'b00: Control_out = 4'b0010; // Load/Store => ADD
        2'b01: begin // Branch instructions
            case (fun3)
                3'b000: Control_out <= 4'b0110; // BEQ -> SUB
                3'b001: Control_out <= 4'b0110; // BNE -> SUB
                3'b100: Control_out <= 4'b0110; // BLT -> SUB
                3'b101: Control_out <= 4'b0110; // BGE -> SUB
                default: Control_out <= 4'b1111;
            endcase
        end
        2'b10: begin // R-type
            case({fun7, fun3})
                4'b0_000: Control_out <= 4'b0010; // ADD
                4'b1_000: Control_out <= 4'b0110; // SUB
                4'b0_111: Control_out <= 4'b0000; // AND
                4'b0_110: Control_out <= 4'b0001; // OR
                4'b0_100: Control_out <= 4'b0011; // XOR
                4'b0_010: Control_out <= 4'b0100; // SLT
                4'b0_001: Control_out <= 4'b0101; // SLL
                4'b0_101: Control_out <= 4'b1001; // SRL
                4'b1_101: Control_out <= 4'b1010; // SRA
                default:  Control_out <= 4'b1111;
            endcase
        end
        default: Control_out <= 4'b1111;
    endcase
end

endmodule