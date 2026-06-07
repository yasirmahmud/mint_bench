module verilator_encapsulated_3_child_1;
  // The original design uses SystemVerilog classes, which are not supported by RTL linting
  // tools like SpyGlass, leading to elaboration errors (ELAB_6312) and preventing
  // the tool from finding a top design unit (NoTopDUFound).
  //
  // To resolve these SpyGlass violations while preserving the functional behavior
  // of accessing and displaying a specific value from an array, we remove the class
  // construct entirely. The 'local_array' with its fixed values is represented
  // as a 'parameter' array within the module. Parameters are constant and inherently
  // local to the module, effectively mimicking the initial data setup.
  
  parameter int local_array[2] = '{30, 31};

  initial begin
    // Accessing local_array[0] now directly refers to the parameter array element.
    // This preserves the original functional behavior of displaying the value 30.
    // The original Verilator ENCAPSULATED warning, related to class encapsulation,
    // is implicitly resolved by transitioning to an RTL-compliant structure where
    // the concept of 'local' class members does not apply in the same problematic way.
    $display("Accessing local_array[0]: %0d", local_array[0]);
  end
endmodule
