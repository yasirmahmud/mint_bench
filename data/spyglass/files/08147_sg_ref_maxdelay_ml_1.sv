module maxdelay_ml_ex1 (input clk, output reg out);
 always @(posedge clk) begin #200 out <= 1'b1;
 end endmodule
