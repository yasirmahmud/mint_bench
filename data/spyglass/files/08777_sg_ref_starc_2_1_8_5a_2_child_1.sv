module nested_subprogram_ex2 (input a, output reg b);

 function automatic int inner_func;
  input int y;
  inner_func = y + 1;
 endfunction

 function automatic int outer_func;
  input int x;
  outer_func = inner_func(x) + 2;
 endfunction

 assign b = outer_func(a);

endmodule
