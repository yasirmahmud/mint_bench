module DiffDelayInNonBlock_ML_ex1 (input clk, rst, in1, in2, output reg out1, out2);
 always @(posedge clk or posedge rst) begin if (rst) begin out1 <= #1 1'b0;
 out2 <= #1 1'b0;
 end else begin out1 <= #1 in1;
 out2 <= #2 in2;
 end end endmodule
