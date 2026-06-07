module example_09(input i);
  function automatic int my_func;
    my_func = 1;
  endfunction
  assign i = my_func();
endmodule
