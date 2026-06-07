module curve_stx_ve_416_20260111_214327_150979_w32456_attempt11 (
  input in_data,
  output out_result
);

  // Declare an internal wire to be used as an invalid input-path terminal.
  wire internal_control_sig;

  // Simple logic to drive the internal wire and avoid unused signal warnings.
  assign internal_control_sig = in_data;

  // Drive the output port to avoid unused port warnings.
  assign out_result = internal_control_sig;

  specify
    // STX_VE_416 violation: 'internal_control_sig' is an internal 'wire',
    // not an input or inout port. Therefore, it is not a valid input-path terminal
    // for a specify block path delay statement.
    (internal_control_sig => out_result) = 1;
  endspecify

endmodule
