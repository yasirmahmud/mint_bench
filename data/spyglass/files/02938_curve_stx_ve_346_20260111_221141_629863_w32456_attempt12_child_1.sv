module curve_stx_ve_346_20260111_221141_629863_w32456_attempt12 (
  input [7:0] in_val,
  output [7:0] func_result
);

  // Declare a parameter. Parameters are compile-time constants and cannot be assigned to at runtime.
  parameter [7:0] CONFIG_VALUE = 8'hA5;

  // Define a function with an 'output' formal argument.
  // The function intends to modify this argument.
  function automatic [7:0] my_processor_func;
    output [7:0] data_out; // Formal argument declared as 'output'
    input [7:0]  data_in;  // A regular input argument
    begin
      // The function attempts to write to 'data_out'.
      data_out = data_in + 8'd1;
      my_processor_func = data_out; // Return the updated value
    end
  endfunction

  // To resolve STX_VE_346:
  // 'CONFIG_VALUE' is a parameter (non-assignable expression).
  // It was previously passed as the actual argument for 'data_out', an 'output' formal argument,
  // which caused a violation when the function attempted to write to 'data_out'.
  // Create an assignable local wire to connect to the 'output' formal argument instead.
  // This preserves the function's internal behavior (writing to 'data_out') and the overall
  // functional behavior, as 'func_result' is derived from the function's return value (data_in + 1),
  // not from the value written into the 'output' argument itself in this specific assignment context.
  wire [7:0] dummy_data_out;

  assign func_result = my_processor_func(dummy_data_out, in_val);

endmodule
