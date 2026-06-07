module my_ff_ex2(input clk, input rst_n, input d, output q);
 reg q = 1'b0;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) q <= 1'b0;
 else q <= d;
 end endmodule
