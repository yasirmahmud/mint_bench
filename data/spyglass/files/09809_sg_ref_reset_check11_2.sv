module reset_check11_ex2 (input clk, rst, d1, d2, output reg q1, q2);
 always @(posedge clk or posedge rst) if (rst) q1 <= 1'b0;
 else q1 <= d1;
 always @(posedge clk or negedge rst) if (!rst) q2 <= 1'b0;
 else q2 <= d2;
 endmodule
