module readclock_ex2(input clk, output reg out_q);
 always @(posedge clk) begin if (clk == 1'b1) out_q <= ~out_q;
 end endmodule
