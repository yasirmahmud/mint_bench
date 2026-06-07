module curve_synth_12604_20260112_003253_093006_w47152_attempt13 (
  input [3:0] sel,
  output reg out
);

  always @(*) begin
    case (sel)
      4'b0000: out = 1'b0;
      4'b0001: out = 1'b1; // First occurrence of label 4'b0001
      4'b0010: out = 1'b0;
      4'b0011: out = 1'b1;
      4'b0100: out = 1'b0;
      4'b0001: out = 1'b0; // Duplicate occurrence of label 4'b0001 - Triggers SYNTH_12604
      default: out = 1'b0; // Covers all other cases to avoid latches
    endcase
  end

endmodule
