`include "Instruction_Memory.v"
`include "Program_Counter.v"
module RISCV_TOP(
    input clk,reset
);

wire [31:0] instructionTop;
Program_Counter Program_Counter(
    .clk(clk),
    .reset(reset),
    .PC_in(),
    .PC_out(instructionTop)
    );

Instruction_Memory Instruction_Memory(.reset(reset),
 .read_address(instructionTop), 
 .instruction_out()
 );

endmodule