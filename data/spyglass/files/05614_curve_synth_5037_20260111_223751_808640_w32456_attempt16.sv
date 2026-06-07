module curve_synth_5037_20260111_223751_808640_w32456_attempt16 (
    input [2:0] sel,
    output reg out_val
);

  always @(*) begin
    // Default assignment to prevent latch inference for out_val
    out_val = 1'b0;

    case (sel)
      3'd0: out_val = 1'b0;
      3'd1: out_val = 1'b1;
      3'd2: out_val = 1'b0;
      3'd3: out_val = 1'b1;
      3'd4: out_val = 1'b0;
      3'd5: out_val = 1'b1;
      3'd6: out_val = 1'b0;
      3'd7: out_val = 1'b1;
      // This case item '4'd8' (binary 1000) is unreachable because 'sel' is a 3-bit signal.
      // A 3-bit signal can only represent integer values from 0 (3'b000) to 7 (3'b111).
      // Therefore, the condition for this branch can never be met, triggering SYNTH_5037.
      4'd8: out_val = 1'b0;
    endcase
  end

endmodule
