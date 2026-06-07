module curve_combloop_20260111_201416_400357_w53504_attempt10 (
  input  wire in_data,
  output wire out_data
);

  wire node_a;
  wire node_b;

  // These two assign statements create a combinational loop:
  // 'node_a' depends on 'node_b' (and 'in_data'),
  // and 'node_b' depends directly on 'node_a'.
  assign node_a = node_b | in_data;
  assign node_b = node_a;

  // Use one of the loop signals for the output to avoid unused signal warnings.
  assign out_data = node_b;

endmodule
