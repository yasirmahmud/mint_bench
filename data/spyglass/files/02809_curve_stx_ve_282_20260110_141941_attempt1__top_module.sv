module top_module (
  input top_in,
  output [1:0] top_out
);

  // Instance 1: This connection will trigger STX_VE_282 for port 'in'
  sub_module i_sub_module_1 (
    .in(top_in),
    .out_s(top_out[0])
  );

  // Instance 2: This connection will also trigger STX_VE_282 for port 'in'
  sub_module i_sub_module_2 (
    .in(top_in),
    .out_s(top_out[1])
  );

endmodule
