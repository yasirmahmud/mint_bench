module flop_undriven_ex1 (input clk, input rst, output reg q);
 wire undriven_data;
 always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0;
 else q <= undriven_data;
 end endmodule
