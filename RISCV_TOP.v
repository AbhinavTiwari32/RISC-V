`include "Instruction_Memory.v"
`include "Program_Counter.v"
`include "ALU_Control.v"
`include "Data_Memory.v"
`include "ALU.v"
`include "Register_File.v"
`include "PCplus4.v"
`include "ImmGen.v"
`include "Mux.v"
`include "AND_logic.v"
`include "Control_Unit.v"


module RISCV_TOP(
    input clk,reset 
);

wire [31:0] PC_top, instruction_Top,NextoPc_top,Sum_out_top,PCin_top,Rd1_top,Rd2_top,Memdata_top ,ALUresultTop,WriteBack_top,ImmExt_top,mux1_top,address_top;
wire [3:0] control_top;
wire RegWrite_top,MemWrite_top,MemRead_top,ALUSrc_top,zero_top,branch_top,sel2_top,MemtoReg_top;
wire [1:0] ALUOpTop;
Program_Counter Program_Counter(
    .clk(clk),
    .reset(reset),
    .PC_in(PCin_top),
    .PC_out(PC_top)
    );

PCplus4 PC_Adder(.fromPC(PC_top),
    .NextoPC(NextoPc_top));

Instruction_Memory Inst_Memory(.clk(clk),
.reset(reset),
 .read_address(PC_top), 
 .instruction_out(instruction_Top)
 );

Register_File Register_File(.clk(clk),
.reset(reset),
.Rs1(instruction_Top[19:15]), 
.Rs2(instruction_Top[24:20]),
.Rd(instruction_Top[11:7]),
.Write_data(WriteBack_top),
.RegWrite(RegWrite_top),
.read_data1(Rd1_top),
.read_data2(Rd2_top)
);
ImmGen ImmGen(.Opcode(instruction_Top[6:0]),
.instruction(instruction_Top),
.ImmExt(ImmExt_top));

ALU_unit ALU_unit(.A(Rd1_top),
.B(mux1_top),
.zero(zero_top),
.Control_in(control_top),
.ALU_Result(address_top)
);

Data_Memory Data_Memory(.clk(clk),
.reset(reset),
.MemWrite(MemWrite_top),
.MemRead(MemRead_top),
.read_address(address_top),
.Write_data(Rd2_top),
.MemData_out(Memdata_top));

ALU_Control ALU_Control(.ALUOp(ALUOpTop),
.fun7(instruction_Top[30]),
.fun3(instruction_Top[14:12]),
.Control_out(control_top));

Control_Unit Control_Unit(.instruction(instruction_Top[6:0]),
.Branch(branch_top),
.MemRead(MemRead_top),
.MemtoReg(MemtoReg_top),
.MemWrite(MemWrite_top),

.ALUSrc(ALUSrc_top),
.RegWrite(RegWrite_top),
.ALUOp(ALUOpTop));

Mux1 ALU_mux(.sel1(ALUSrc_top),
.A1(Rd2_top),
.B1(ImmExt_top),
.Mux1_out(mux1_top));

AND_logic AND(.branch(branch_top),
.zero(zero_top),
.and_out(sel2_top));

Adder Adder(.in_1(PC_top),
.in_2(ImmExt_top),
.Sum_out(Sum_out_top));

Mux2 Adder_mux(.sel2(sel2_top),
.A2(NextoPc_top),
.B2(Sum_out_top),
.Mux2_out(PCin_top));

Mux3 Memory_mux(.sel3(MemtoReg_top),
.A3(address_top),
.B3(Memdata_top),
.Mux3_out(WriteBack_top));




endmodule