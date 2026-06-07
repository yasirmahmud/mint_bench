module nested_subprogram_ex1(input a, output b);

  // Define inner_func separately at the module level
  function automatic integer inner_func(input integer y);
    return y + 1;
  endfunction

  // Define outer_func, which can now call inner_func
  function automatic integer outer_func(input integer x);
    return inner_func(x) + x;
  endfunction

  assign b = outer_func(a);

endmodule
