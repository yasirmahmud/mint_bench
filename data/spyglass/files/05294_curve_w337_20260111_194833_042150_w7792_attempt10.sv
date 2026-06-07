module curve_w337_20260111_194833_042150_w7792_attempt10 (
  input [3:0] selector_in,
  output reg  result_out
);

  always @* begin
    result_out = 1'b0; // Default assignment to prevent latch inference

    // W337 violation: Illegal value as case item.
    // In a 'casez' statement, 'z' is treated as a don't care, but 'x' is treated
    // as a specific state that must be matched bit-for-bit. Using 'x' in a
    // 'casez' item like '4'b01x0' is considered an "illegal value" by SpyGlass
    // because typically, case items are expected to specify definite 0/1 values
    // or 'z' don't cares in a 'casez'. Relying on an explicit 'x' match is
    // problematic for synthesis and generally indicates a design issue or intent
    // that doesn't map well to hardware.
    //
    // This pattern is directly inspired by provided context example #2 (2'b1x in casez)
    // which also triggered SYNTH_5034. The challenge of triggering *only* W337 without
    // SYNTH_5034 or W496b is significant because synthesis tools typically assume
    // inputs are '0' or '1' and cannot achieve 'x' or 'z' states. This assumption
    // often leads to comparisons with 'x' or 'z' in case items being flagged as
    // "always false" (SYNTH_5034/W496b). This example aims to be as minimal as possible
    // for W337 without introducing other explicit design flaws (latches, multi-drivers).
    casez (selector_in) // 'z' in selector_in will be a don't care
      4'b0000: result_out = 1'b0;
      4'b0001: result_out = 1'b1;
      4'b001z: result_out = 1'b0; // 'z' is a don't care here, allowed in casez
      // This item contains 'x' and is expected to trigger W337.
      4'b01x0: result_out = 1'b1; 
      4'b0111: result_out = 1'b0;
      default: result_out = 1'b0; // Ensure full case coverage
    endcase
  end

endmodule
