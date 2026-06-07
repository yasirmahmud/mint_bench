module top_module (
  input wire clk,
  output wire top_out
);
  wire dummy_in_conn;
  wire dummy_out_conn;

  // Connect input 'clk' to 'dummy_in_conn' to ensure usage
  assign dummy_in_conn = clk;

  // Instantiate sub_module, attempting to assign a bit-vector concatenation
  // ({1'b0, 1'b1}) to the string parameter 'P'. This type mismatch is
  // expected to trigger the STX_VE_299 violation: Incompatible connection to parameter 'P'.
  sub_module #(.P({1'b0, 1'b1})) inst_sub (
    .dummy_in(dummy_in_conn),
    .dummy_out(dummy_out_conn)
  );

  // Connect 'dummy_out_conn' to 'top_out' to ensure usage
  assign top_out = dummy_out_conn;
endmodule
