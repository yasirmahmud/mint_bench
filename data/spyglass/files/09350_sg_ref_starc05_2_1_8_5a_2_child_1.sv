module nested_subprogram_ex2 (input a, output b);
 function automatic [0:0] outer_func (input [0:0] in1);
  function automatic [0:0] inner_func (input [0:0] in2);
  inner_func = in2;
  endfunction // Terminate inner_func
  outer_func = inner_func(in1); // Assignment for outer_func
 endfunction // Terminate outer_func
 assign b = outer_func(a);
 endmodule
