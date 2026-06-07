module curve_combloop_20260111_231308_440406_w32456_attempt12 (
  input wire in_data,
  output reg out_data
);

  // This 'always @*' block creates a combinational loop.
  // 'out_data' depends directly on its own previous value via the XOR operation,
  // forming an unstable condition that SpyGlass detects as a combinational loop.
  always @* begin
    out_data = out_data ^ in_data;
  end

endmodule
