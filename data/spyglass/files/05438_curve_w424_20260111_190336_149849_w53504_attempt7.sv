module curve_w424_20260111_190336_149849_w53504_attempt7 (
  input wire [7:0] data_in,
  output wire [7:0] func_result_out,
  output wire [7:0] global_var_out
);

  // Module-level register, considered 'global' for functions within this module
  reg [7:0] module_global_data;

  // Function that updates a 'global' module-level register
  function [7:0] process_and_update_global;
    input [7:0] func_input_val;
    begin
      // W424 violation: Function 'process_and_update_global' sets global variable 'module_global_data'
      module_global_data = func_input_val + 5;
      process_and_update_global = func_input_val * 2;
    end
  endfunction

  // Call the function to ensure it is used
  assign func_result_out = process_and_update_global(data_in);

  // Read the 'global' variable to avoid 'variable set but not read' warnings (W528)
  assign global_var_out = module_global_data;

endmodule
