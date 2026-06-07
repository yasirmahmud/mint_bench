module top_module_ex1;
  // Unroll the instance array to resolve the 'set but not read' violation (W528)
  // and implicitly address the AvoidInstArray-ML context.
  // The output 'b' is left unconnected as it was not used further in the original design.
  my_sub_module inst_array_0 (.a(1'b0), .b());
  my_sub_module inst_array_1 (.a(1'b0), .b());
 endmodule
