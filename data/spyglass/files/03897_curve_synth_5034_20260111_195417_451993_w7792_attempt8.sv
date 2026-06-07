module curve_synth_5034_20260111_195417_451993_w7792_attempt8 (
  input [3:0] in_bus,
  output reg out_val
);

  always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casez (in_bus)
      4'b0001: out_val = 1'b1;
      4'b001x: out_val = 1'b0; // SYNTH_5034: Comparison with don't care or tristate will be always false
      4'b0100: out_val = 1'b1;
      default: out_val = 1'b0;
    endcase
  end

endmodule
