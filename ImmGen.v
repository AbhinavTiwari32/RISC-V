module ImmGen(
    input [6:0] Opcode,
    input [31:0] instruction,
    output reg [31:0] ImmExt
);
always @(*) begin
    case(Opcode)
        7'b0000011,  
        7'b0010011,  
        7'b1100111: 
            ImmExt <= {{20{instruction[31]}}, instruction[31:20]}; // I-type

        7'b0100011:  // sw
            ImmExt <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // S-type

        7'b1100011:  // beq, bne, etc.
            ImmExt <= {{19{instruction[31]}}, instruction[31], instruction[7],
                        instruction[30:25], instruction[11:8], 1'b0}; // B-type

        default:
            ImmExt <= 32'd0;
    endcase
end
endmodule