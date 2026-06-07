module reset_check11_ex1 (input clk, input rst_n_or_p, input d1, input d2, output reg q1, output reg q2);
 always @(posedge clk or posedge rst_n_or_p) begin if (rst_n_or_p) begin q1 <= 1'b0;
 end else begin q1 <= d1;
 end end always @(posedge clk or negedge rst_n_or_p) begin if (!rst_n_or_p) begin q2 <= 1'b0;
 end else begin q2 <= d2;
 end end endmodule
