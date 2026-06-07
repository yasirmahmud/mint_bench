module curve_stx_ve_416_20260111_214327_150979_w32456_attempt12 (
  input  in_valid,
  input  sys_clk,
  output out_data
);

  reg internal_reg_input; // Internal 'reg'

  // Always block to drive the internal 'reg' synchronously,
  // avoiding latches and ensuring it's used.
  always @(posedge sys_clk) begin
    internal_reg_input <= in_valid;
  end

  // Drive the output port to avoid unused port warnings.
  assign out_data = internal_reg_input;

  specify
    // STX_VE_416 violation: 'internal_reg_input' is an internal 'reg',
    // not an input or inout port. Therefore, it is not a valid input-path terminal
    // for a specify block path delay statement.
    (internal_reg_input => out_data) = 1;
  endspecify

endmodule
