module curve_stx_ve_346_20260111_181723_830533_w47100_attempt9 (
  input wire [7:0] in_data,
  output wire [7:0] out_result
);

  // Define an automatic function with an input and an output argument.
  // The 'formal_output' argument is declared as 'output'.
  function automatic [7:0] my_func;
    input  [7:0] formal_input;
    output [7:0] formal_output; // This is the formal 'output' argument of the function
    begin
      formal_output = formal_input + 1; // The function attempts to write to this output argument
      my_func = formal_input * 2;       // Return value of the function
    end
  endfunction

  wire [7:0] func_return_val;
  // Declare a temporary wire to pass as the actual argument for 'formal_output'.
  // This resolves STX_VE_346 by providing an assignable expression, as 'output' arguments
  // cannot be connected to non-assignable expressions like numeric literals.
  wire [7:0] dummy_func_output;

  assign func_return_val = my_func(in_data, dummy_func_output);

  // Connect the function's return value to the module output to avoid unused signal warnings.
  assign out_result = func_return_val;

endmodule
