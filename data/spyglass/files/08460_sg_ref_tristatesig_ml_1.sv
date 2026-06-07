module TristateSig_ML_ex1(clk, rst, in1, r1);
 input clk;
 input rst;
 input in1;
 output reg r1;
 always @(posedge clk) begin if (rst) r1 <= in1;
 else r1 <= 1'bz;
 end endmodule
