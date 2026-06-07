module curve_stx_ve_417_20260110_143927_attempt5 (
  input a_in
);

  // This 'specify' block directly triggers STX_VE_417.
  // 'pulsestyle_onevent' expects an 'output-path' (an output or inout port),
  // but 'a_in' is declared as an input port.
  specify
    pulsestyle_onevent a_in;
  endspecify

  // 'a_in' is considered used by its reference in the 'specify' block,
  // preventing an 'unused signal' warning. Since there are no output ports,
  // there is no 'undriven output' warning. The expectation is that the
  // FATAL syntax error STX_VE_417 will prevent the SYNTH_92 warning
  // (related to synthesis tool support for specify blocks) from being reported,
  // thus achieving exactly one violation for the target rule.

endmodule
