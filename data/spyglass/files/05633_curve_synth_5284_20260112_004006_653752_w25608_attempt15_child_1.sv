module curve_synth_5284_20260112_004006_653752_w25608_attempt15 (
    input [1:0] selector_in,
    output reg output_reg
);

  always @* begin
    // The original design used floating-point constants (3.1, 4.2) as case items
    // for an integer selector (selector_in, 2 bits). This is a non-synthesizable
    // construct (SYNTH_5284) and leads to other violations (W263, W337).
    // A 2-bit integer selector can never match a floating-point value.
    // Therefore, in the original code, the 'default' case (output_reg = 1'b0)
    // would always be active for any valid input of 'selector_in', after the
    // initial assignment of output_reg = 1'b0. The effective functional behavior
    // was that 'output_reg' would always be '1'b0'.
    // To preserve this functional behavior and resolve all synthesis violations,
    // 'output_reg' is simply assigned to '1'b0'.
    output_reg = 1'b0;
  end

endmodule
