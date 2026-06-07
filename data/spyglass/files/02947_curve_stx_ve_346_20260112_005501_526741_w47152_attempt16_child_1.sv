module curve_stx_ve_346_20260112_005501_526741_w47152_attempt16 (
  input [7:0] in_data,
  input       sel_cond,
  output [7:0] out_val
);

  // A Verilog function that has an 'output' formal argument.
  // The function attempts to write to this argument.
  // To resolve STX_VE_346, the redundant 'output' formal argument `processed_data_out` is removed.
  // This argument was not contributing to the function's primary return value calculation
  // and its usage with an rvalue caused the violation.
  function automatic [7:0] my_processor_func;
    input [7:0] data_in_param;
    // Removed 'output reg [7:0] processed_data_out' as it's redundant
    // and its connection to an rvalue caused STX_VE_346.
    begin
      // The function's return value is now directly assigned the processed data.
      my_processor_func = data_in_param + 8'd10;
    end
  endfunction

  wire [7:0] func_return_val;

  // STX_VE_346 violation resolved: The 'output' formal argument has been removed from the function.
  // The function call is updated to reflect the new function signature, passing only the input.
  // The functional behavior of 'out_val' (which is 'in_data + 8'd10') is preserved.
  assign func_return_val = my_processor_func(in_data);

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign out_val = func_return_val;

endmodule
