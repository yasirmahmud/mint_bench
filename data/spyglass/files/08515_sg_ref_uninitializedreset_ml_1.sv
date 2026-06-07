module UnInitializedReset_ML_ex1 (clk, rst, data_in, out_q);
 input clk;
 input rst;
 input data_in;
 output reg out_q;
 reg internal_reg;
 always @(posedge clk or posedge rst) begin if (rst) begin out_q <= internal_reg;
 end else begin internal_reg <= data_in;
 out_q <= data_in;
 end end endmodule
