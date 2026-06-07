module curve_w424_20260111_190336_149849_w53504_attempt6 (
  input wire [7:0] data_in,
  output wire [7:0] result_out
);

  // Module-level variable, considered 'global' for functions within this module
  reg [7:0] shared_data;

  // Function that updates a 'global' module-level variable
  function [7:0] compute_and_store;
    input [7:0] fn_input_val;
    begin
      // W424 violation: Function 'compute_and_store' sets global variable 'shared_data'
      shared_data = fn_input_val + 2;
      compute_and_store = fn_input_val * 3;
    end
  endfunction

  // Call the function to ensure it's used and its effect on shared_data can be observed
  assign result_out = compute_and_store(data_in);

endmodule
