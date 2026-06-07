module curve_stx_ve_346_20260112_005501_526741_w47152_attempt16 (
  input [7:0] in_data,
  input       sel_cond,
  output [7:0] out_val
);

  // A Verilog function that has an 'output' formal argument.
  // The function attempts to write to this argument.
  function automatic [7:0] my_processor_func;
    input [7:0] data_in_param;
    output reg [7:0] processed_data_out; // This is the formal 'output' argument
    begin
      // The function attempts to write to 'processed_data_out'.
      // If the actual argument passed is an rvalue expression, this will cause STX_VE_346.
      processed_data_out = data_in_param + 8'd10; // Simple operation to write to the output
      my_processor_func = processed_data_out; // Return the updated value
    end
  endfunction

  wire [7:0] func_return_val;

  // STX_VE_346 violation: Passing a conditional expression (ternary operator)
  // to an 'output' formal argument ('processed_data_out').
  // A conditional expression (sel_cond ? in_data : 8'hFF) is an rvalue (non-assignable)
  // and cannot be written to by the function. The function attempts to assign to 'processed_data_out'.
  assign func_return_val = my_processor_func(in_data, (sel_cond ? in_data : 8'hFF));

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign out_val = func_return_val;

endmodule
