module starc_2_1_8_1_ex1;
 reg [7:0] a;
 reg [7:0] b;
 function [7:0] add_func;
 input [7:0] val1;
 input [7:0] val2;
 begin add_func = val1 + val2;
 end endfunction assign b = add_func(a, 8'd5);
 endmodule
