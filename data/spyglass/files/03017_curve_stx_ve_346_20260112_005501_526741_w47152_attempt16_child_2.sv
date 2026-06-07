module curve_stx_ve_346_20260112_005501_526741_w47152_attempt16 (
  input [7:0] in_data,
  input       sel_cond,
  output [7:0] out_val
);

  // A Verilog function that returns a value based on its input.
  // The original function used an 'output' formal argument which was redundant
  // because the function's explicit return value was identical to what was
  // assigned to the 'output' argument. This redundancy caused STX_VE_346.
  function automatic [7:0] my_processor_func;
    input [7:0] data_in_param;
    begin
      // Directly return the processed data.
      // This avoids the need for an 'output reg' formal argument,
      // resolving STX_VE_346 and simplifying the function.
      my_processor_func = data_in_param + 8'd10;
    end
  endfunction

  wire [7:0] func_return_val;

  // STX_VE_346 violation fix:
  // The 'output' formal argument 'processed_data_out' has been removed from
  // the function definition as it was redundant with the function's return value.
  // Consequently, the temporary wire 'temp_output_arg' is no longer needed
  // and the function is called with only its actual input argument.
  assign func_return_val = my_processor_func(in_data);

  // Connect the function's return value to the module output.
  assign out_val = func_return_val;

endmodule
