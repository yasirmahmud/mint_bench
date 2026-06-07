module curve_synth_12604_20260111_175443_586439_w37940_attempt6 (
  input [2:0] sel,
  output reg out
);

  always @(*) begin
    // Default assignment to ensure output is always driven
    out = 1'b0;

    unique case (sel)
      3'd0: out = 1'b0;
      3'd1: out = 1'b1; // First occurrence of 3'd1 label
      3'd2: out = 1'b0;
      3'd3: out = 1'b1;
      3'd1: out = 1'b0; // Duplicate occurrence of 3'd1 label - Triggers SYNTH_12604
      3'd4: out = 1'b0;
      3'd5: out = 1'b1;
      3'd6: out = 1'b0;
      3'd7: out = 1'b1;
    endcase
  end

endmodule
