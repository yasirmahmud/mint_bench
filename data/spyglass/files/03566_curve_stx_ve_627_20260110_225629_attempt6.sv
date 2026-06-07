module curve_stx_ve_627_20260110_225629_attempt6;

  // A function requiring two integer input arguments
  function automatic integer process_values;
    input integer val1;
    input integer val2;
    process_values = val1 * val2;
  endfunction

  initial begin
    integer final_val;
    // VIOLATION: Calling process_values with too few arguments (expected two, got one)
    final_val = process_values(7);
  end

endmodule
