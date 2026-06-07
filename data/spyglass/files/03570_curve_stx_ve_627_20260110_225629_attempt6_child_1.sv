module curve_stx_ve_627_20260110_225629_attempt6;

  // A function requiring two integer input arguments
  function automatic integer process_values;
    input integer val1;
    input integer val2;
    process_values = val1 * val2;
  endfunction

  initial begin
    integer final_val;
    // FIX: Added a second argument to resolve the STX_VE_627 violation.
    // The value '1' is chosen to minimally impact the result if '7' was the primary intended input.
    final_val = process_values(7, 1);
  end

endmodule
