module curve_w287b_20260111_194449_406742_w53504_attempt9 (
  input sys_a,
  input sys_b,
  output sys_result
);

  // Instantiate sub-module, leaving one output port unconnected to trigger W287b
  my_logic_gate u_logic (
    .i_a    (sys_a),
    .i_b    (sys_b),
    .o_and  (), // W287b violation: Instance output port 'o_and' is not connected
    .o_xor  (sys_result)
  );

endmodule
