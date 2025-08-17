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
`include "IFID_Reg.v"
`include "IDEXE_Reg.v"
`include "EXMEM_Reg.v"
`include "MEMWB_Reg.v"

module RISCV_TOP(
    input clk,reset 
);

wire [31:0] PC_top, instruction_Top,NextoPc_top,EXSum_out_top,PCin_top,Rd1_top,Rd2_top,Memdata_top ,ALUresultTop,WriteBack_top,ImmExt_top,mux1_top,address_top;
wire [3:0] control_top;
wire RegWrite_top,MemWrite_top,MemRead_top,ALUSrc_top,zero_top,branch_top,sel2_top,MemtoReg_top;
wire EXRegWrite_top,EXMemWrite_top,EXMemRead_top,EXALUSrc_top,EXbranch_top,EXMemtoReg_top;
wire [1:0] EXALUOpTop;
wire [31:0] EXPC_top,EXRd1_top,EXRd2_top,EXImmExt_top;
wire [1:0] ALUOpTop;
wire PCSrc_top;
wire [31:0] MEMADD_out_top;
wire [31:0] MEMRd2_out_top;

wire[2:0] EXfunc3_top;
wire EXfunc7_top;
wire [4:0] EXRd_top,MEMRd_top,WBRd_top;
wire MEMRegWrite_top,MEMMemWrite_top,MEMMemRead_top,MEMALUSrc_top,MEMbranch_top,MEMMemtoReg_top;
wire [31:0] PCID_wire,MEMALURes_out_top,WBALURes_top;
wire MEMBranch_out_top,MEMZero_top;

wire [31:0] Instruction_ID,WBReadData_top;
wire WBMemtoReg_top,WBRegWrite_top;
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
.Rs1(Instruction_ID[19:15]), 
.Rs2(Instruction_ID[24:20]),
.Rd(WBRd_top),
.Write_data(WriteBack_top),
.RegWrite(WBRegWrite_top),
.read_data1(Rd1_top),
.read_data2(Rd2_top)
);
ImmGen ImmGen(.Opcode(Instruction_ID[6:0]),
.instruction(Instruction_ID),
.ImmExt(ImmExt_top));

ALU_unit ALU_unit(.A(EXRd1_top),
.B(mux1_top),
.zero(zero_top),
.Control_in(control_top),
.ALU_Result(address_top)
);

Data_Memory Data_Memory(.clk(clk),
.reset(reset),
.MemWrite(MEMMemWrite_top),
.MemRead(MEMMemRead_top),
.read_address(MEMALURes_out_top),
.Write_data(MEMRd2_out_top),
.MemData_out(Memdata_top));

ALU_Control ALU_Control(.ALUOp(EXALUOpTop),
.fun7(EXfunc7_top),
.fun3(EXfunc3_top),
.Control_out(control_top));

Control_Unit Control_Unit(.instruction(Instruction_ID[6:0]),
.Branch(branch_top),
.MemRead(MemRead_top),
.MemtoReg(MemtoReg_top),
.MemWrite(MemWrite_top),

.ALUSrc(ALUSrc_top),
.RegWrite(RegWrite_top),
.ALUOp(ALUOpTop));

Mux1 ALU_mux(.sel1(EXALUSrc_top),
.A1(EXRd2_top),
.B1(EXImmExt_top),
.Mux1_out(mux1_top));

AND_logic AND(.branch(MEMBranch_out_top),
.zero(MEMZero_top),
.and_out(PCSrc_top));

Adder Adder(.in_1(EXPC_top),
.in_2(EXImmExt_top),
.Sum_out(EXSum_out_top));

Mux2 Adder_mux(.sel2(PCSrc_top),
.A2(NextoPc_top),
.B2(MEMADD_out_top),
.Mux2_out(PCin_top));

Mux3 Memory_mux(.sel3(WBMemtoReg_top),
.A3(WBALURes_top),
.B3(WBReadData_top),
.Mux3_out(WriteBack_top));

IFID_Reg IFID_Reg(
    .clk(clk),
    .rst(reset),
    .IFPCin(PCin_top),
    .IFProgMem_in(instruction_Top),
    .IDPCout(PCID_wire),
    .IDProgMem_out(Instruction_ID));

IDEXE_Reg IDEXE_Reg(.clk(clk), .rst(reset),
 .IDALUSrc_in(ALUSrc_top), .IDMemtoReg_in(MemtoReg_top), .IDRegWrite_in(RegWrite_top), .IDMemRead_in(MemRead_top), .IDMemWrite_in(MemWrite_top), .IDBranch_in(branch_top), 
 .IDALUOp_in(ALUOpTop),
 .IDPC_in(PCID_wire),
 .IDRd1_in(Rd1_top),
 .IDRd2_in(Rd2_top),

 .IDImmGen_in(ImmExt_top),
.IDfunc3_in(Instruction_ID[14:12]),
.IDfunc7_in(Instruction_ID[30]),
.IDRd_in(Instruction_ID[11:7]),

 .EXEALUSrc_out(EXALUSrc_top),
  .EXEMemtoReg_out(EXMemtoReg_top), 
  .EXERegWrite_out(EXRegWrite_top), 
  .EXEMemRead_out(EXMemRead_top), 
  .EXEMemWrite_out(EXMemWrite_top), 
  .EXEBranch_out(EXbranch_top), 

.EXEALUOp_out(EXALUOpTop),
 .EXEPC_out(EXPC_top),
 .EXERd1_out(EXRd1_top),
 .EXERd2_out(EXRd2_top),
 .EXEImmGen_out(EXImmExt_top),
.EXEfunc3_out(EXfunc3_top),
.EXEfunc7_out(EXfunc7_top),
 .EXERd_out(EXRd_top));

 EXMEM_Reg EXMEM_Reg( .clk(clk),
 .rst(reset), .EXMemtoReg_in(EXMemtoReg_top), .EXRegWrite_in(EXRegWrite_top), .EXMemRead_in(EXMemRead_top), .EXMemWrite_in(EXMemWrite_top), .EXBranch_in(EXbranch_top),
 .EXADD_in(EXSum_out_top),.EXALURes_in(address_top),
.EXRd2_in(EXRd2_top), .EXRd_in(EXRd_top),
.EXZero_in(zero_top),
 .MEMMemtoReg_out(MEMMemtoReg_top), .MEMRegWrite_out(MEMRegWrite_top), .MEMMemRead_out(MEMMemRead_top), .MEMMemWrite_out(MEMMemWrite_top), .MEMBranch_out(MEMBranch_out_top),
 .MEMADD_out(MEMADD_out_top),.MEMALURes_out(MEMALURes_out_top),
 .MEMRd2_out(MEMRd2_out_top), .MEMRd_out(MEMRd_top),
 .MEMZero_out(MEMZero_top));

 MEMWB_Reg MEMWB_reg(
     .clk(clk), .rst(reset),
    
     .MEMMemtoReg_in(MEMMemtoReg_top), .MEMRegWrite_in(MEMRegWrite_top),
    
    .MEMReadData_in(Memdata_top), .MEMALURes_in(MEMALURes_out_top),
     .MEMRd_in(MEMRd_top),

    
    .WBMemtoReg_out(WBMemtoReg_top), .WBRegWrite_out(WBRegWrite_top),
    .WBReadData_out(WBReadData_top),  .WBALURes_out(WBALURes_top),
    .WBRd_out(WBRd_top)
);





endmodule