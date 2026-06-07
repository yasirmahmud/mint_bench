module curve_synth_5284_20260112_004006_653752_w25608_attempt14 (
    input [1:0] selector_val,
    output reg result_out
);

  always @* begin
    result_out = 1'b0; // Default assignment to avoid latches

    // SYNTH_5284: Non synthesizable construct: floating point type constant.
    // The rule description (w337_ex1) and previous attempts indicate this rule
    // is triggered by using a floating-point constant as a case item for an
    // integer selector. This inherently also triggers W263 (width mismatch)
    // and W337 (illegal value as case item). It appears that SYNTH_5284
    // is specifically linked to this construct, making W263 and W337
    // unavoidable co-violations in this context.
    case (selector_val)
      2'b00:   result_out = 1'b0;
      2.5:     result_out = 1'b1;   // Occurrence 1: Floating point constant
      default: result_out = 1'b0;
    endcase
  end

endmodule
