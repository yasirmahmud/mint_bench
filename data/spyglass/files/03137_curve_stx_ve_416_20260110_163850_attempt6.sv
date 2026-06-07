module curve_stx_ve_416_20260110_163850_attempt6 ();

  // Declare an internal register. This is not an input port.
  reg internal_sig;
  wire output_sig;

  // A minimal functional use for internal_sig and output_sig to avoid potential
  // unused signal warnings, which are not the target violation.
  assign output_sig = internal_sig;

  specify
    // STX_VE_416 violation: 'internal_sig' is an internal register, not a valid
    // input port or inout port, making it an invalid input-path terminal for a specify block.
    (internal_sig => output_sig) = 1;
  endspecify

endmodule
