module w456_violation_ex2 (input a, input b, input c, output reg out);
 always @(a or b or c) begin out = a & b;
 end endmodule
