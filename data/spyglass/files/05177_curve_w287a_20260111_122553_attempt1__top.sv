module top (
  output out_top
);
  // Declare a wire that will not be driven by any source.
  wire undriven_signal;

  // Instantiate 'sub' and connect its input 'in_port_sub'
  // to the undriven 'undriven_signal'.
  // This connection is expected to trigger the W287a violation.
  sub u_sub (
    .in_port_sub (undriven_signal)
  );

  // Drive the output port 'out_top' to prevent an unused signal warning.
  assign out_top = 1'b0;

endmodule
