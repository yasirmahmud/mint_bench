module curve_synth_5284_20260110_160021_attempt1 (
  input [1:0] sel,
  output reg out
);

  always @(*) begin
    case (sel)
      2'b00: out = 1'b0;
      1.5:   out = 1'b1; // Triggers SYNTH_5284
      2'b01: out = 1'b0;
      3.0:   out = 1'b1; // Triggers SYNTH_5284
      default: out = 1'b0;
    endcase
  end

endmodule
