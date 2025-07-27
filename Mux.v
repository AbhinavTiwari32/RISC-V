module Mux1(sel1,A1,B1,Mux1_out);

input sel1;
input [31:0] A1,B1;
output [31:0] Mux1_out;

assign Mux1_out =(sel1==1'b0) ?A1 : B1;

endmodule

module Mux2(sel2,A2,B2,Mux2_out);

input sel2;
input [31:0] A2,B2;
output [31:0] Mux2_out;

assign Mux2_out =(sel2==1'b0) ?A2 : B2;

endmodule

module Mux3(sel3,A3,B3,Mux3_out);

input sel3;
input [31:0] A3,B3;
output [31:0] Mux3_out;

assign Mux3_out =(sel3==1'b0) ?A3 : B3;

endmodule