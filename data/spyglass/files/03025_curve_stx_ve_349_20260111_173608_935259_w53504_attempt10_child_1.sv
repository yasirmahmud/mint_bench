module curve_stx_ve_349_20260111_173608_935259_w53504_attempt10 (
  // No ports needed for this example
);

  initial begin
    // STX_VE_349 violation: Calling 'exit' as an undefined task or function.
    $finish; // Replaced 'exit' with '$finish' to resolve the undefined task/function error and terminate simulation.
  end

endmodule
