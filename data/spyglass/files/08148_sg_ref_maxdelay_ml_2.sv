module maxdelay_ml_ex2(input clk, output reg out);
 always @(posedge clk) begin #20 out <= 1'b1;
 end endmodule
