module top_ex2 (input clk, input rst, output reg out_val);
 wire w_a, w_b, w_c;
 assign w_a = clk;
 assign w_c = rst;
 sub_ex2 i_sub_ex2 (.in_a(w_a), .in_c(w_c), .out_b(w_b));
 always @(posedge clk or posedge rst) begin if (rst) begin out_val <= 1'b0;
 end else begin out_val <= w_b;
 end end endmodule
