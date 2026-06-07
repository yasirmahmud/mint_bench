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
      // This will cause a violation if 'data_out' is connected to a non-assignable actual argument.
      data_out = data_in + 8'd1;
      my_processor_func = data_out; // Return the updated value
    end
  endfunction

  // Trigger STX_VE_346:
  // 'CONFIG_VALUE' is a parameter, which is a non-assignable expression.
  // It is passed as the actual argument for 'data_out', which is an 'output' formal argument.
  // The function attempts to write to 'data_out', effectively trying to write to 'CONFIG_VALUE'.
  // This is an invalid operation, as a parameter cannot be written to, thus triggering STX_VE_346.
  assign func_result = my_processor_func(CONFIG_VALUE, in_val);

endmodule
