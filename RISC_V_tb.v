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

        
        #10 reset = 0;

        
        #1000 $finish;
    end

    
    initial begin
        
       $monitor("PC: %h, Rd1: %d, Rd2: %d, Zero: %b, Branch: %b, sel2: %b, Next PC: %h",
         uut.PC_top, uut.Rd1_top, uut.Rd2_top, uut.zero_top, uut.branch_top, uut.sel2_top, uut.PCin_top);

       
    end

endmodule
