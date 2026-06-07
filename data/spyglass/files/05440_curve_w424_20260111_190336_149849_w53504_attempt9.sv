module curve_w424_20260111_190336_149849_w53504_attempt9 (
  input wire [3:0] input_data,
  output wire [3:0] function_result,
  output wire [3:0] current_module_state
);

  // Declare a module-level register. This is considered a 'global' variable
  // that a function within this module should not modify.
  reg [3:0] module_state_reg;

  // Function definition: this function will incorrectly modify a module-level variable.
  function [3:0] calculate_and_update_state;
    input [3:0] func_input; // Input to the function
    begin
      // W424 violation: Function 'calculate_and_update_state' is setting the
      // module-level variable 'module_state_reg'.
      module_state_reg = func_input + 1; // Distinct operation and width from previous attempt
      calculate_and_update_state = func_input * 2; // Result of the function
    end
  endfunction

  // Instantiate the function call to ensure it is exercised and its side effect occurs.
  assign function_result = calculate_and_update_state(input_data);

  // Read the 'global' state register to prevent 'set but not read' warnings (e.g., W528).
  assign current_module_state = module_state_reg;

  // Initialize the module-level register to avoid X propagation or synthesis warnings.
  initial begin
    module_state_reg = 4'h0;
  end

endmodule
