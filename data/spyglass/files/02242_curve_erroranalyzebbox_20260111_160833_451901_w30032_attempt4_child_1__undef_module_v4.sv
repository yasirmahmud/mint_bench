module undef_module_v4 (
  input wire i_clk,
  input wire i_rst,
  input wire [7:0] i_data,
  output wire [7:0] o_data
);
  // Simple pass-through behavior to satisfy the interface for linting purposes.
  // This ensures the module is defined and not treated as a black-box.
  assign o_data = i_data;
endmodule
