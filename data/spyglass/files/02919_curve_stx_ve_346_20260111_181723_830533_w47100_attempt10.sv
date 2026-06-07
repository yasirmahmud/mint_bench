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

  // Define a localparam to be used as an invalid actual argument.
  localparam [7:0] NON_ASSIGNABLE_CONSTANT = 8'hCE;

  wire [7:0] function_return_val;

  // Trigger STX_VE_346 (Occurrence 1):
  // Pass a localparam (NON_ASSIGNABLE_CONSTANT) to 'arg_output_b',
  // which is an 'output' formal argument.
  // A localparam is a constant, non-assignable expression and cannot be written to by the function.
  // This makes it an invalid actual argument for an 'output' formal argument.
  assign function_return_val = my_processor_func(data_in, NON_ASSIGNABLE_CONSTANT);

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign data_out = function_return_val;

endmodule
