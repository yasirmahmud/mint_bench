module curve_stx_ve_346_20260111_221141_629863_w32456_attempt11 (
  input [7:0] data_input,
  output [7:0] function_return_value
);

  // Define a function with an 'output' formal argument.
  // The function intends to modify this argument.
  function automatic [7:0] my_update_func;
    output [7:0] out_ref; // Formal argument declared as 'output'
    input [7:0]  in_val;  // A regular input argument
    begin
      // The function attempts to write to 'out_ref'.
      out_ref = in_val + 8'd10;
      my_update_func = out_ref; // Return the updated value
    end
  endfunction

  // Trigger STX_VE_346:
  // 'data_input' is an input port to the module, hence it is non-assignable.
  // When 'data_input' is passed as the actual argument for 'out_ref'
  // (which is an 'output' formal argument), the function attempts to write to 'data_input'.
  // This violates the rule because an input port cannot be written to.
  assign function_return_value = my_update_func(data_input, 8'd5);

endmodule
