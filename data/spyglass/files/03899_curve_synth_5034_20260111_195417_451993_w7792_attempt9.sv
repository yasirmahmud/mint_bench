module curve_synth_5034_20260111_195417_451993_w7792_attempt9 (
  input [2:0] in_sel,
  output reg out_val
);

  always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    case (in_sel)
      3'b001: out_val = 1'b1;
      3'b01x: out_val = 1'b0; // SYNTH_5034: Comparison with don't care ('x') will always be false in synthesis
      3'b100: out_val = 1'b1;
      default: out_val = 1'b0;
    endcase
  end

endmodule
