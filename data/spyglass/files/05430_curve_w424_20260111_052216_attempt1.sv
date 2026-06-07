module curve_w424_20260111_052216_attempt1 (
  input wire [7:0] in_data,
  output wire [7:0] out_data
);

  // Declare a 'global' variable accessible by the function
  reg [7:0] global_var_w424;

  // Function that modifies the 'global' variable
  function [7:0] calculate_and_set_global;
    input [7:0] func_input;
    begin
      // W424 Violation: Function should not set a global variable
      global_var_w424 = func_input + 5;
      calculate_and_set_global = func_input * 2;
    end
  endfunction

  // Use the function and the 'global' variable to avoid unused signal warnings
  assign out_data = calculate_and_set_global(in_data) + global_var_w424;

endmodule
