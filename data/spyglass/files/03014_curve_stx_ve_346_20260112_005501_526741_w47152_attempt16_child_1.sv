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
  // Declare a temporary wire to serve as an lvalue for the 'output' formal argument.
  // The value of this wire will be updated by the function.
  // Since the function's explicit return value is also 'processed_data_out',
  // this wire holds the same value as 'func_return_val'.
  wire [7:0] temp_output_arg;

  // STX_VE_346 violation fix:
  // Pass an lvalue (temp_output_arg) to the 'output' formal argument ('processed_data_out').
  // The conditional expression (sel_cond ? in_data : 8'hFF) was an rvalue and cannot be
  // written to by the function. In the original, buggy code, this expression's value
  // would have been ignored by the function because 'processed_data_out' is immediately
  // assigned a new value derived from 'data_in_param'.
  // Thus, removing the conditional expression from this position preserves the effective
  // functional behavior of 'out_val' (which was 'in_data + 8'd10').
  assign func_return_val = my_processor_func(in_data, temp_output_arg);

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign out_val = func_return_val;

endmodule
