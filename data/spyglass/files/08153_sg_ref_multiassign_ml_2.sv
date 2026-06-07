module multi_assign_ex2 (input clk, input rst_n, input in_a, input in_b, output reg out_q);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin out_q <= 1'b0;
 end else begin out_q <= in_a;
 out_q <= in_b;
 end end endmodule
