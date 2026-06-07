module my_module_ex2 (input clk, input rst, input data_in);
 reg q_unused;
 always @(posedge clk or posedge rst) begin if (rst) q_unused <= 1'b0;
 else q_unused <= data_in;
 end endmodule
