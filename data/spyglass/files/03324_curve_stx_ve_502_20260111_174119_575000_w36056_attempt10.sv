module curve_stx_ve_502_20260111_174119_575000_w36056_attempt10 (
  input wire enable_i,
  output wire done_o
);

  // A minimal assignment to avoid unused signal warnings and ensure a valid module structure.
  assign done_o = enable_i;

  // This `endif` compiler directive is intentionally placed here
  // without a preceding `ifdef` or `ifndef` to trigger STX_VE_502.
  // This should be the only violation.
`endif

endmodule
