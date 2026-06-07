module curve_stx_ve_505_20260111_175104_670724_w37940_attempt8 (
  output reg out_signal
);

  // The `end_keywords compiler directive is incorrectly placed inside a design element (the 'initial' block, which is within the module).
  // This placement is expected to trigger exactly one STX_VE_505 violation.
  initial begin
    out_signal = 1'b0;
  end

endmodule
