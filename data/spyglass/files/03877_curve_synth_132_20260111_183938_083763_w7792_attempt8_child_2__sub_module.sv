module sub_module #(
  parameter SUB_PARAM = 1
) (
  // No ports, as 'sub_clk' was removed.
);
  // A simple sub-module with a parameter
  // Input port 'sub_clk' removed as it was unused, resolving W240.
endmodule
