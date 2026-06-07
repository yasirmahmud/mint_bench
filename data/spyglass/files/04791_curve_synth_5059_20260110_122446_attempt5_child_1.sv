module curve_synth_5059_20260110_122446_attempt5 (
  input wire in1,
  input wire in2,
  output reg out_neq
);

  // SYNTH_5059: Case inequality (!==) encountered which is not supported by synthesis.
  // Using the case inequality operator (!==) in an always block's conditional statement
  // directly targets SYNTH_5059. Inputs are 1-bit and do not involve X/Z values
  // to avoid co-triggering STARC05-2.10.1.4b, which was observed in previous attempts.
  // This structure aligns with the provided context example for SYNTH_5059.
  always @* begin
    if (in1 !== in2) begin // This line is intended to trigger SYNTH_5059
      out_neq = 1'b1;
    end else begin
      out_neq = 1'b0;
    end
  end

endmodule
