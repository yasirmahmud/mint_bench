module implicit_inst_example ();
  // Resolve WIR_NR_IMPL, W287a, and UndrivenInTerm-ML:
  // 'another_implicit_wire' was implicitly declared and undriven.
  // Explicitly declare the wire and drive it with a constant value
  // to preserve the "undriven" (non-functional) behavior.
  wire another_implicit_wire;
  assign another_implicit_wire = 1'b0;

  sub_mod u_sub (
    .a(another_implicit_wire)
  );
endmodule
