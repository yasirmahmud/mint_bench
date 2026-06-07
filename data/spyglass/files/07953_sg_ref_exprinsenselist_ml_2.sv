module ExprInSenseList_ex2(input a, b, output reg out);
 always @(a || b) out = a && b;
 endmodule
