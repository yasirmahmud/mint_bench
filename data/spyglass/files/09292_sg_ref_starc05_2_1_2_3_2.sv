module starc05_ex2;
 reg global_var;
 function integer my_func;
 input [0:0] dummy;
 begin my_func = global_var + dummy;
 end endfunction endmodule
