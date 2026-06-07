module curve_latchfeedback_20260111_085925_attempt4 (
  input wire enable_i,
  input wire data_in_i,
  output reg latch_out_o
);

  always @(*) begin
    if (enable_i) begin
      // A level-sensitive latch is inferred for 'latch_out_o'.
      // The output 'latch_out_o' is fed back into its own input, creating a feedback path.
      // This causes a potential feedback race condition for the latch.
      latch_out_o = latch_out_o ^ data_in_i;
    end
    // When enable_i is '0', 'latch_out_o' retains its previous value, thus inferring a latch.
  end

endmodule
