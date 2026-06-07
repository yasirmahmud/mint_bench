module CheckAsyncHold_ML_ex1 (input clk, input cond, output reg q);
 always @(cond) begin q <= cond ? q : 1'b0;
 end endmodule
