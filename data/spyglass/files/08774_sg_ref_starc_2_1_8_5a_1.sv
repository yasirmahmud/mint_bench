module nested_func_ex1;
 function automatic int outer_func;
 input int a;
 begin function automatic int inner_func;
 input int b;
 begin return b * 2;
 end endfunction return a + inner_func(a);
 end endfunction endmodule
