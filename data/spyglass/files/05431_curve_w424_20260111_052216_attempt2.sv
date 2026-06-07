module curve_w424_20260111_052216_attempt2 (
  input wire [15:0] data_in,
  output wire [15:0] data_out
);

  // Declare a 'global' variable accessible by the function
  reg [15:0] module_shared_data;

  // Function that modifies the 'global' variable
  function [15:0] process_and_update_state;
    input [15:0] func_input_val;
    begin
      // W424 Violation: Function should not set a global variable
      module_shared_data = func_input_val - 10;
      process_and_update_state = func_input_val / 2;
    end
  endfunction

  // Use the function and the 'global' variable to avoid unused signal warnings
  assign data_out = process_and_update_state(data_in) + module_shared_data;

endmodule
