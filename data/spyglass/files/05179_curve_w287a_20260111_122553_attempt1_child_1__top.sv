module top (
  output out_top
);
  // Declare a wire that was previously undriven.
  wire undriven_signal;

  // RESOLUTION for W287a (Input 'undriven_signal' of instance 'u_sub' is undriven)
  // and UndrivenInTerm-ML (Detected undriven input terminal top.u_sub.in_port_sub).
  // Drive the signal with a constant value. This preserves the functional
  // intent that it's not functionally driven by design logic, but makes
  // the linter happy that it's not floating.
  assign undriven_signal = 1'b0;

  // Instantiate 'sub' and connect its input 'in_port_sub'
  // to the now driven 'undriven_signal'.
  sub u_sub (
    .in_port_sub (undriven_signal)
  );

  // Drive the output port 'out_top' to prevent an unused signal warning.
  assign out_top = 1'b0;

endmodule
