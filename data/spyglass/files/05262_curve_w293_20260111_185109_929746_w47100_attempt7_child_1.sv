module curve_w293_20260111_185109_929746_w47100_attempt7;

  function integer calculate_sqrt; // Changed from 'real' to 'integer' to resolve W293 violation
    input integer value_in;
    begin
      // The result of $sqrt($itor(value_in)) is 'real'.
      // Assigning a 'real' to an 'integer' implicitly truncates the real value.
      calculate_sqrt = $sqrt($itor(value_in));
    end
  endfunction

endmodule
