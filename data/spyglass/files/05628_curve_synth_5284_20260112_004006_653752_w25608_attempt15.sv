module curve_synth_5284_20260112_004006_653752_w25608_attempt15 (
    input [1:0] selector_in,
    output reg output_reg
);

  always @* begin
    output_reg = 1'b0; // Default assignment to avoid latches

    // SYNTH_5284: Non synthesizable construct: floating point type constant.
    // This rule is triggered by using floating-point constants as case items for an integer selector.
    // This construct is inherently non-synthesizable in Verilog-2001 for hardware description.
    // Per the rule's common trigger, this will lead to two occurrences of SYNTH_5284.
    // Due to the nature of using floating-point values as case items for an integer selector,
    // co-violations such as W263 (case label width mismatch) and W337 (illegal value as case item)
    // are typically unavoidable. The ErrorAnalyzeBBox rule (ERROR) is also a general consequence
    // of the design being non-synthesizable.
    case (selector_in)
      3.1:     output_reg = 1'b1; // Occurrence 1: Floating point constant
      4.2:     output_reg = 1'b0; // Occurrence 2: Floating point constant
      default: output_reg = 1'b0;
    endcase
  end

endmodule
