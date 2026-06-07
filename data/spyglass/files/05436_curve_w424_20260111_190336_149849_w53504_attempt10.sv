module curve_w424_20260111_190336_149849_w53504_attempt10 (
  input wire [7:0] input_data,
  output wire [7:0] function_result,
  output wire [7:0] current_module_status
);

  // Declare a module-level register. This is considered a 'global' variable
  // that a function within this module should not modify.
  reg [7:0] module_status_reg;

  // Function definition: this function will incorrectly modify a module-level variable.
  function [7:0] calculate_and_update_status;
    input [7:0] func_input; // Input to the function
    begin
      // W424 violation: Function 'calculate_and_update_status' is setting the
      // module-level variable 'module_status_reg'.
      module_status_reg = func_input | 8'hF0; // Distinct operation and width from previous attempts
      calculate_and_update_status = func_input + 1; // Result of the function
    end
  endfunction

  // Instantiate the function call to ensure it is exercised and its side effect occurs.
  assign function_result = calculate_and_update_status(input_data);

  // Read the 'global' state register to prevent 'set but not read' warnings (e.g., W528).
  assign current_module_status = module_status_reg;

  // Removed the initial block to avoid triggering SYNTH_5143 found in previous attempts.

endmodule
