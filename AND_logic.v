module AND_logic(branch,zero,and_out);
input branch,zero;
output and_out;

assign and_out =branch &zero;

endmodule

module Adder(in_1,in_2,Sum_out);

input [31:0]  in_1,in_2;
output [31:0]  Sum_out;
assign Sum_out = in_1 + in_2;
endmodule