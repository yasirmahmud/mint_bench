module recursive_func_ex1 (input [3:0] a, output [7:0] b);
 function [7:0] factorial;
 input [3:0] n;
 if (n <= 1) begin factorial = 1;
 end else begin factorial = n * factorial(n - 1);
 end endfunction assign b = factorial(a);
 endmodule
