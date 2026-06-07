// Third declaration of 'fifo_controller'.
// This re-declaration triggers the second STX_VE_589 violation.
// It will also reference the initial declaration at line 5.
module fifo_controller (
  output wire almost_full,
  output wire almost_empty
);

  assign almost_full = 1'b0;
  assign almost_empty = 1'b1;

endmodule
