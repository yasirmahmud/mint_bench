module STARC05_2_1_2_2_ex1;
 function automatic [7:0] my_func;
 input [7:0] a;
 reg [7:0] b;
 begin b <= a + 1;
 my_func = b;
 end endfunction endmodule
