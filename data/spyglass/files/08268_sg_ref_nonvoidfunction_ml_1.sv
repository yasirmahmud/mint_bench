module NonVoidFunction_ML_ex1;
 reg a;
 function integer my_func;
 a = 1'b1;
 endfunction initial begin my_func();
 end endmodule
