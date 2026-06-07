module w122_violation_ex2 (input a, input b, output reg out);
 always @(a) begin out = a & b;
 end endmodule
