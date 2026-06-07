module badimplicitSM2_ex1(input clk, input d, output reg q);
 always @(posedge clk or negedge clk) begin if (clk) q <= d;
 else q <= ~d;
 end endmodule
