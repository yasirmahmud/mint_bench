module curve_w424_20260111_190336_149849_w53504_attempt8 (
  input wire [7:0] data_input,
  output wire [7:0] function_output,
  output wire [7:0] state_snapshot
);

  // Declare a module-level register. This is considered a 'global' variable
  // that a function within this module should not modify.
  reg [7:0] shared_state_register;

  // Function definition: this function will incorrectly modify a module-level variable.
  function [7:0] compute_and_update_state;
    input [7:0] func_param; // Input to the function
    begin
      // W424 violation: Function 'compute_and_update_state' is setting the
      // module-level variable 'shared_state_register'.
      shared_state_register = func_param ^ 8'hFF; // Distinct operation to change from previous attempts
      compute_and_update_state = func_param + 10; // Result of the function
    end
  endfunction

  // Instantiate the function call to ensure it is exercised and its side effect occurs.
  assign function_output = compute_and_update_state(data_input);

  // Read the 'global' state register to prevent 'set but not read' warnings (e.g., W528).
  assign state_snapshot = shared_state_register;

endmodule
