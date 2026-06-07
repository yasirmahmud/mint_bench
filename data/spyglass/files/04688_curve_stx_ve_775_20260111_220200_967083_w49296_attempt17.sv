module curve_stx_ve_775_20260111_220200_967083_w49296_attempt17 ();

  // This function scope is a disallowed location for an initial statement.
  // This should trigger the STX_VE_775 violation (occurrence 1).
  function automatic void my_function_a();
    initial begin
      integer temp_a;
      temp_a = 1;
      $display("Initial in function A: %0d", temp_a);
    end
  endfunction

  // A second instance to meet the "Total occurrences: 2" requirement
  // for the STX_VE_775 violation (occurrence 2).
  function automatic void my_function_b();
    initial begin
      integer temp_b;
      temp_b = 2;
      $display("Initial in function B: %0d", temp_b);
    end
  endfunction

endmodule
