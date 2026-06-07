module bothedges_ex1 (input clk, output reg q);
 always @(posedge clk or negedge clk) begin q <= ~q;
 end endmodule
