module starc02_1_1_1_7_ex1 (input clk, input reset, input d, output reg q);
 always @(posedge clk) begin q <= d;
 if (!reset) begin q <= 1'b0;
 end end endmodule
