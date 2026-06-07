module my_module_ex2();
 function automatic [7:0] my_func;
 input [7:0] a;
 reg [7:0] b;
 begin b <= a;
 my_func = b;
 end endfunction endmodule
