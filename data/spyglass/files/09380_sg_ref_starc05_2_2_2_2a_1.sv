module starc05_2_2_2_2a_ex1 (input a, input b, input c, output reg out);
 always @(a or b or c) begin out = a & b;
 end endmodule
