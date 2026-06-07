module curve_stx_ve_346_20260111_181723_830533_w47100_attempt10 (
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // Define an automatic function with an input and an output argument.
  function automatic [7:0] my_processor_func;
    input  [7:0] arg_input_a;
    output [7:0] arg_output_b; // This is the formal 'output' argument
    begin
      arg_output_b = arg_input_a + 1; // The function writes to this output argument
      my_processor_func = arg_input_a * 2; // Return value of the function
    end
  endfunction

  localparam [7:0] NON_ASSIGNABLE_CONSTANT = 8'hCE;

  wire [7:0] function_return_val;
  // Declare a wire to capture the value assigned to the 'output' argument by the function.
  // This resolves the STX_VE_346 violation by providing an assignable target.
  wire [7:0] function_output_b_val;

  // Call the function, passing an assignable wire for its 'output' argument
  // to resolve the STX_VE_346 violation.
  assign function_return_val = my_processor_func(data_in, function_output_b_val);

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign data_out = function_return_val;

endmodule
