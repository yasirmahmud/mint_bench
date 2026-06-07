module curve_synth_5405_20260111_051450_attempt3 (
  input [1:0] latch_enable_multi_bit, // Multi-bit signal acting as a latch enable
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // This always block describes a level-sensitive latch for 'data_out'.
  // The sensitivity list includes 'latch_enable_multi_bit', which is a 2-bit signal.
  // Synthesis tools might interpret the signal in the sensitivity list of a latch
  // as a "clock expression" in a broader sense (e.g., enable clock).
  // If 'latch_enable_multi_bit' is treated as a clock expression for the latch,
  // its multi-bit width would trigger SYNTH_5405.
  //
  // This design explicitly avoids 'posedge' or 'negedge' on 'latch_enable_multi_bit'
  // to prevent triggering W218 ("Edge specification should not be used for a multibit expression").
  // If SYNTH_5405 is strictly tied to edge-triggered clocks (posedge/negedge),
  // this attempt might not trigger SYNTH_5405, or might trigger other latch-related warnings.
  always @(latch_enable_multi_bit or data_in) begin
    if (latch_enable_multi_bit[0]) begin // A single bit of the multi-bit enable acts as the actual data enable
      data_out = data_in;
    end
    // 'data_out' is not assigned in the 'else' branch, inferring a latch.
  end

endmodule
