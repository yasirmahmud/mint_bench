module curve_w424_20260111_052216_attempt5 (
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // Declare a module-level variable. Naming it 'global_data' to explicitly match
  // the rule's description, which refers to 'global_data'.
  // Using 'reg' with an explicit width [7:0] to avoid the W216 violation
  // encountered in the previous attempt (which occurred when indexing an 'integer').
  reg [7:0] global_data;

  // A combinational function that modifies the module-level 'global_data'.
  function [7:0] set_global_and_return;
    input [7:0] func_input_val;
    begin
      // W424 Violation: A function should not modify a variable declared outside its scope.
      // This assignment to 'global_data' is a side effect, triggering the rule.
      global_data = func_input_val + 3; // Assigns to the module-level 'global_data'

      // The function must return a value.
      set_global_and_return = func_input_val * 2;
    end
  endfunction

  // Call the function. The function's return value is used, and it also
  // has a side effect on 'global_data'. Both the function's return and
  // the updated 'global_data' are used to drive the module output,
  // ensuring all declared signals are utilized and preventing unused signal warnings.
  assign data_out = set_global_and_return(data_in) + global_data;

endmodule
