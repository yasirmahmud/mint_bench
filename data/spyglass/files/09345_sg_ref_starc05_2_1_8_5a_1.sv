module nested_subprogram_ex1(input a, output b);
 function automatic integer outer_func(input integer x);
 function automatic integer inner_func(input integer y);
 return y + 1;
 endfunction return inner_func(x) + x;
 endfunction assign b = outer_func(a);
 endmodule
