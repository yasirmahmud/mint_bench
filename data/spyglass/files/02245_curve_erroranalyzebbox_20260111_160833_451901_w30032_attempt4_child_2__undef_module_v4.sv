module undef_module_v4 (
  input wire i_clk,
  input wire i_rst,
  input wire [7:0] i_data,
  output wire [7:0] o_data
);
  // Simple pass-through behavior to satisfy the interface for linting purposes.
  // This ensures the module is defined and not treated as a black-box.

  // To resolve W240 warnings (inputs declared but not read),
  // we explicitly use i_clk and i_rst without altering the data path
  // or introducing sequential logic.
  wire unused_clk = i_clk;
  wire unused_rst = i_rst;

  assign o_data = i_data;
endmodule
