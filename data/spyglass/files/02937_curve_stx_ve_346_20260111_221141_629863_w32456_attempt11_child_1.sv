module curve_stx_ve_346_20260111_221141_629863_w32456_attempt11 (
  input [7:0] data_input,
  output [7:0] function_return_value
);

  // Define a function. The original 'output' formal argument 'out_ref' has been
  // removed as it was only used to hold an intermediate value before being assigned
  // to the function's return value. This was the cause of the STX_VE_346 violation.
  // By removing it, 'data_input' is no longer incorrectly passed to an 'output' argument.
  function automatic [7:0] my_update_func;
    input [7:0]  in_val;  // A regular input argument
    begin
      // The function now directly calculates and assigns its return value.
      my_update_func = in_val + 8'd10;
    end
  endfunction

  // STX_VE_346 is resolved:
  // 'data_input' is no longer passed as an actual argument to an 'output' formal argument.
  // The functional behavior, where function_return_value becomes (8'd5 + 8'd10 = 8'd15),
  // is preserved, as the original 'data_input' value was not used in the calculation
  // for the function's return value.
  assign function_return_value = my_update_func(8'd5);

endmodule
