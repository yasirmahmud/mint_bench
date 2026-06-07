module curve_stx_ve_416_20260110_163850_attempt10 (
  output out_port_valid_path
);

  // This internal 'wire' will be used as the input-path terminal in the specify block.
  // Since it is not an input or inout port, it will trigger STX_VE_416.
  wire internal_wire_invalid_path;

  // Drive the internal wire with a constant to avoid unused signal warnings.
  assign internal_wire_invalid_path = 1'b0;

  // Drive the output port with a constant to avoid unused signal warnings.
  // 'out_port_valid_path' is an 'output' port (implicitly a wire), making it a valid
  // output-path terminal in the specify block. This prevents STX_VE_418.
  assign out_port_valid_path = 1'b0;

  specify
    // STX_VE_416 violation: 'internal_wire_invalid_path' is an internal 'wire',
    // not an input or inout port. This makes it an invalid input-path terminal.
    (internal_wire_invalid_path => out_port_valid_path) = 1;
  endspecify

endmodule
