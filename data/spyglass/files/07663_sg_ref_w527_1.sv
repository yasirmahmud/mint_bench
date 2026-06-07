module dangling_else_ex1(input a, input b, output reg out);
 always @* if (a) if (b) out = 1'b1;
 else out = 1'b0;
 endmodule
