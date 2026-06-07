module W245_ex2;
 reg a, b, c;
 always @(a || b) begin c <= a && b;
 end endmodule
