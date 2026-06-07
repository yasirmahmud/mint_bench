module curve_synth_12604_20260112_003253_093006_w47152_attempt14 (
  input [2:0] sel,
  output reg out
);

  always @(*) begin
    case (sel)
      3'b000: out = 1'b0;
      3'b001: out = 1'b1; // First occurrence of label 3'b001
      3'b010: out = 1'b0;
      3'b100: out = 1'b1; // First occurrence of label 3'b100
      3'b101: out = 1'b0;
      3'b001: out = 1'b0; // Duplicate occurrence of label 3'b001 - Triggers SYNTH_12604 (1st violation)
      3'b110: out = 1'b1;
      3'b100: out = 1'b0; // Duplicate occurrence of label 3'b100 - Triggers SYNTH_12604 (2nd violation)
      3'b011: out = 1'b1; // Cover remaining case 3'b011 to avoid latches
      3'b111: out = 1'b0; // Cover remaining case 3'b111 to avoid latches
    endcase
  end

endmodule
