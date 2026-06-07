module mixed_reset_edges_ex1(input clk, input rst_n, output reg q);
 always @(posedge clk or negedge rst_n or posedge rst_n) begin if (!rst_n) begin q <= 1'b0;
 end else if (rst_n) begin q <= 1'b1;
 end else begin q <= ~q;
 end end endmodule
