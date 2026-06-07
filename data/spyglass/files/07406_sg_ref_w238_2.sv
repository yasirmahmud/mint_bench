module w238_ex2 (input a, b, output reg c, d);
 always @* begin c <= a & b;
 d = a | b;
 end endmodule
