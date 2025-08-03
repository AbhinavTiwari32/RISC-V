`timescale 1ns/1ps
`include "RISCV_TOP.v"

module tb();

    reg clk, reset;
    // For monitoring purpose


    
    RISCV_TOP uut (
        .clk(clk),
        .reset(reset)
    );
    

   
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Waveform dump        
        clk = 0;
     

     reset = 1;        
        #10 reset =0;
        #100 $finish;
    end

    
    initial begin
        
      $monitor("Time: %0t | PC: %0d | Instr: %0h | rs1: x%0d = %0d | rs2: x%0d = %0d | Imm: %0d | Addr: %0d | WriteData: %0d | MemWrite: %0b | Data1 = %0d|Data2 = %0d| ALUSrc=%0b",
         $time,
         uut.PC_top,                          // Program Counter
         uut.instruction_Top,                 // Current instruction
         uut.instruction_Top[19:15],          // rs1 register number
         uut.Rd1_top,                         // rs1 value (base address)
         uut.instruction_Top[24:20],          // rs2 register number
         uut.Rd2_top,                         // rs2 value (data to be stored)
         uut.ImmExt_top,                      // Immediate value
         uut.address_top,                     // ALU result (effective memory address)
         uut.WriteBack_top,                         // Data to be written to memory
         uut.MemWrite_top,                     // MemWrite control signal
         uut.Data_Memory.D_Memory[14],
          uut.Register_File.Registers[8],
          uut.Control_Unit.ALUSrc

);       

    end

    initial begin 
        $dumpfile("RISC_V.vcd");
        $dumpvars(0, tb);
    end

endmodule
