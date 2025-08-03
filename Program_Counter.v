module Program_Counter (
    input clk,           // Clock signal
    input reset,         // Active-high reset
    input [31:0] PC_in,  // Next PC value (from adder or branch logic)
    output reg [31:0] PC_out // Current PC value
);

always @(posedge clk or posedge reset) begin
    if (reset)
        PC_out <= 32'b0;       // Reset PC to 0
    else
        PC_out <= PC_in;       // Update PC at posedge clk
end

endmodule
