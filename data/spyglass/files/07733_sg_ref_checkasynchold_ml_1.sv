module CheckAsyncHold_ML_ex1 (input clk, input cond, output reg q);
 always @(posedge clk or cond) begin q <= cond ? q : 1'b0;
 end endmodule
