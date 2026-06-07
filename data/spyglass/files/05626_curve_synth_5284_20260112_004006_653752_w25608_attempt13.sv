module curve_synth_5284_20260112_004006_653752_w25608_attempt13 (
    input [1:0] selector_val,
    output reg result_out
);

  always @* begin
    // Default assignment to avoid latches. All paths explicitly assign result_out.
    result_out = 1'b0; 

    // SYNTH_5284: Non synthesizable construct: floating point type constant.
    // Using floating-point constants as case items for an integer 'selector_val'
    // directly triggers SYNTH_5284 for each occurrence.
    case (selector_val)
      2'b00: result_out = 1'b0;
      2.5: result_out = 1'b1;   // Occurrence 1: Floating point constant
      3.14: result_out = 1'b0;  // Occurrence 2: Floating point constant
      default: result_out = 1'b0;
    endcase
  end

endmodule
