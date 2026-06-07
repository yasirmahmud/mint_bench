module lint_ex2 (input [1:0] a, output [1:0] b);
 function [1:0] f_ex2;
 input [1:0] i;
 reg [1:0] r[0:1];
 begin r = '{0:i, 1:2'd1};
 f_ex2 = r[0];
 end endfunction assign b = f_ex2(a);
 endmodule
