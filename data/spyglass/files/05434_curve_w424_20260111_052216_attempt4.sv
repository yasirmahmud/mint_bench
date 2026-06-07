module curve_w424_20260111_052216_attempt4 (
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // Declare a module-level variable. This acts as the "global_data" 
  // that the W424 rule refers to, as it's accessible from functions.
  integer global_data;

  // A combinational function that will modify the module-level 'global_data'.
  function [7:0] process_data;
    input [7:0] func_input;
    begin
      // W424 Violation: A function should not modify a variable declared outside its scope.
      // This assignment to 'global_data' is a side effect.
      global_data = func_input + 1; // Assigns to the module-level 'global_data'

      // The function must return a value.
      process_data = func_input * 2;
    end
  endfunction

  // Call the function and use the updated 'global_data' to ensure both are utilized 
  // and to drive the output, preventing unused signal warnings.
  assign data_out = process_data(data_in) + global_data[7:0];

endmodule
