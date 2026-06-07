module readclock_ex1 (input clk, output reg out_reg);
 always @(posedge clk) begin if (clk == 1'b1) out_reg <= 1'b1;
 else out_reg <= 1'b0;
 end endmodule
