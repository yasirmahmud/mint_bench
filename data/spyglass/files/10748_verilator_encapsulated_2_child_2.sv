module verilator_encapsulated_2_child_1;
  // The original Verilog used a SystemVerilog class, which caused SpyGlass ELAB_6312 error
  // due to unsupported constructs during elaboration. SystemVerilog classes are primarily
  // for verification environments and are often not supported by synthesis/linting tools
  // targeted at synthesizable RTL.
  //
  // To resolve the ELAB_6312 error while preserving the behavior of returning '20',
  // the class has been removed and its functionality is replaced by a module-level 'function'.
  // This makes the design synthesizable (if applicable) and compatible with linting tools.
  //
  // The 'NoTopDUFound' error is also resolved as the module is now a standard,
  // recognizable top-level design unit.

  function automatic int get_value_20();
    return 20;
  endfunction

  initial begin
    $display("Calling function: %0d", get_value_20());
  end
endmodule
