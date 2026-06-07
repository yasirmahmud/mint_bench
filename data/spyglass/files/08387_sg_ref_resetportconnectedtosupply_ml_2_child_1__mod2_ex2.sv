module mod2_ex2 (input clk, input rst_n, output reg q);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) q <= 1'b0;
 else q <= ~q;
 end
endmodule
